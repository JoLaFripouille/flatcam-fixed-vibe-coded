# Easy Windows setup entrypoint.
# This wrapper calls the real setup script in scripts/windows.

$script = Join-Path $PSScriptRoot "scripts\windows\Setup-FlatCAM.ps1"
& powershell -ExecutionPolicy Bypass -File $script @args
