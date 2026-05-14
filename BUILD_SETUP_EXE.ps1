# Build the Windows installer FlatCAM-Fixed-Setup.exe.
#
# This creates a portable Python runtime inside build\python-runtime before
# compiling the Inno Setup installer. The generated Setup.exe should not depend
# on the developer machine's Python install path.

$ErrorActionPreference = "Stop"
$repoRoot = $PSScriptRoot
$isccCandidates = @(
    (Join-Path $env:LOCALAPPDATA "Programs\Inno Setup 6\ISCC.exe"),
    "C:\Program Files (x86)\Inno Setup 6\ISCC.exe",
    "C:\Program Files\Inno Setup 6\ISCC.exe"
)

$iscc = $isccCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
if (-not $iscc) {
    throw "Inno Setup compiler not found. Install it with: winget install --id JRSoftware.InnoSetup -e"
}

$venvPython = Join-Path $repoRoot ".venv\Scripts\python.exe"
if (-not (Test-Path -LiteralPath $venvPython)) {
    Write-Host "No .venv found. Running Windows setup first..." -ForegroundColor Yellow
    & powershell -ExecutionPolicy Bypass -File (Join-Path $repoRoot "SETUP_WINDOWS.ps1")
}

& $venvPython -c "import PyQt6, shapely, rasterio; print('Installer dependency check OK')"
if ($LASTEXITCODE -ne 0) {
    throw "Installer dependency check failed."
}

$runtimeDir = Join-Path $repoRoot "build\python-runtime"
$basePythonDir = & $venvPython -c "import sys; print(sys.base_prefix)"
$venvSitePackages = & $venvPython -c "import site; print(next(p for p in site.getsitepackages() if p.endswith('site-packages')))"
$runtimeSitePackages = Join-Path $runtimeDir "Lib\site-packages"

if (-not (Test-Path -LiteralPath (Join-Path $basePythonDir "pythonw.exe"))) {
    throw "Base Python runtime not found at: $basePythonDir"
}
if (-not (Test-Path -LiteralPath $venvSitePackages)) {
    throw "Virtualenv site-packages not found at: $venvSitePackages"
}

Write-Host "Preparing portable Python runtime..." -ForegroundColor Cyan
if (Test-Path -LiteralPath $runtimeDir) {
    Remove-Item -LiteralPath $runtimeDir -Recurse -Force
}
New-Item -ItemType Directory -Path $runtimeDir | Out-Null

Copy-Item -Path (Join-Path $basePythonDir "*") -Destination $runtimeDir -Recurse -Force
New-Item -ItemType Directory -Path $runtimeSitePackages -Force | Out-Null
Copy-Item -Path (Join-Path $venvSitePackages "*") -Destination $runtimeSitePackages -Recurse -Force

foreach ($cacheDir in Get-ChildItem -LiteralPath $runtimeDir -Recurse -Force -Directory -Filter "__pycache__") {
    Remove-Item -LiteralPath $cacheDir.FullName -Recurse -Force
}
foreach ($compiledFile in Get-ChildItem -LiteralPath $runtimeDir -Recurse -Force -File | Where-Object { $_.Extension -in @(".pyc", ".pyo") }) {
    Remove-Item -LiteralPath $compiledFile.FullName -Force
}

$runtimePython = Join-Path $runtimeDir "python.exe"
$env:PYTHONNOUSERSITE = "1"
& $runtimePython -s -c "import PyQt6, shapely, rasterio; print('Portable runtime check OK')"
if ($LASTEXITCODE -ne 0) {
    throw "Portable runtime dependency check failed."
}

$iss = Join-Path $repoRoot "installer\FlatCAM-Fixed.iss"
& $iscc $iss

$setup = Join-Path $repoRoot "dist\FlatCAM-Fixed-Setup.exe"
if (-not (Test-Path -LiteralPath $setup)) {
    throw "Installer build failed: $setup not found."
}

Write-Host ""
Write-Host "Installer created:" -ForegroundColor Green
Write-Host $setup
