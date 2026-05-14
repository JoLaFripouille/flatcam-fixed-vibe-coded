param(
    [string]$InstallDir = "",
    [switch]$InstallGdal,
    [switch]$CreateDesktopShortcut
)

$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message)
    Write-Host ""
    Write-Host "==> $Message" -ForegroundColor Cyan
}

function Resolve-RepoRoot {
    $scriptDir = Split-Path -Parent $PSCommandPath
    return (Resolve-Path (Join-Path $scriptDir "..\..")).Path
}

function Find-Python311 {
    $candidates = @()

    $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
    if ($pythonCmd) {
        $candidates += $pythonCmd.Source
    }

    $pyCmd = Get-Command py -ErrorAction SilentlyContinue
    if ($pyCmd) {
        try {
            $py311 = & py -3.11 -c "import sys; print(sys.executable)" 2>$null
            if ($LASTEXITCODE -eq 0 -and $py311) {
                $candidates += $py311.Trim()
            }
        } catch {
            # Ignore launcher lookup failures and keep checking other candidates.
        }
    }

    foreach ($candidate in ($candidates | Select-Object -Unique)) {
        $version = & $candidate -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')" 2>$null
        if ($LASTEXITCODE -eq 0 -and $version.Trim() -eq "3.11") {
            return $candidate
        }
    }

    throw "Python 3.11 introuvable. Installe Python 3.11 puis relance ce script."
}

$repoRoot = if ($InstallDir) { (Resolve-Path $InstallDir).Path } else { Resolve-RepoRoot }
$venvDir = Join-Path $repoRoot ".venv"
$launcher = Join-Path $repoRoot "FlatCAM-Fixed.cmd"
$requirements = Join-Path $repoRoot "requirements.txt"
$windowsRequirements = Join-Path $repoRoot "requirements-windows-generated.txt"

Write-Step "Repository"
Write-Host $repoRoot

Write-Step "Python 3.11"
$python = Find-Python311
Write-Host "Using: $python"

Write-Step "Virtual environment"
if (-not (Test-Path $venvDir)) {
    & $python -m venv $venvDir
}

$venvPython = Join-Path $venvDir "Scripts\python.exe"
$venvPythonw = Join-Path $venvDir "Scripts\pythonw.exe"
if (-not (Test-Path $venvPython)) {
    throw "Virtual environment creation failed: $venvPython missing."
}

Write-Step "Pip upgrade"
& $venvPython -m pip install --upgrade pip setuptools wheel

Write-Step "Dependencies"
$requirementsLines = Get-Content -LiteralPath $requirements
if ($InstallGdal) {
    & $venvPython -m pip install -r $requirements
} else {
    $requirementsLines |
        Where-Object { $_.Trim().ToLowerInvariant() -ne "gdal" } |
        Set-Content -LiteralPath $windowsRequirements -Encoding ASCII
    & $venvPython -m pip install -r $windowsRequirements
}

Write-Step "Import smoke test"
& $venvPython -c "import PyQt6, shapely, rasterio; print('Imports OK')"

if (-not $InstallGdal) {
    Write-Host ""
    Write-Host "GDAL Python bindings were skipped on Windows by default." -ForegroundColor Yellow
    Write-Host "FlatCAM normally launches without them in this fork. Use -InstallGdal if you really need them."
}

Write-Step "Launcher"
$cmd = @"
@echo off
cd /d "$repoRoot"
start "" "$venvPythonw" "$repoRoot\flatcam.py"
"@
Set-Content -LiteralPath $launcher -Value $cmd -Encoding ASCII
Write-Host "Created: $launcher"

if ($CreateDesktopShortcut) {
    Write-Step "Desktop shortcut"
    $desktop = [Environment]::GetFolderPath("Desktop")
    $shortcutPath = Join-Path $desktop "FlatCAM Fixed.lnk"
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $launcher
    $shortcut.WorkingDirectory = $repoRoot
    $shortcut.Description = "Launch FlatCAM Fixed Vibe Coded"
    $shortcut.Save()
    Write-Host "Created: $shortcutPath"
}

Write-Step "Done"
Write-Host "Launch FlatCAM with:"
Write-Host $launcher
