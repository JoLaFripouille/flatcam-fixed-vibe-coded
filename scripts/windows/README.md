# Windows setup

FlatCAM Fixed Vibe Coded is validated with Python 3.11 on Windows.

## Quick install

Open PowerShell in the repository folder and run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\Setup-FlatCAM.ps1 -CreateDesktopShortcut
```

The script will:

- find Python 3.11
- create `.venv`
- install `requirements.txt`, skipping `gdal` by default on Windows because pip
  otherwise tries to compile native GDAL headers
- run a small import smoke test
- create `FlatCAM-Fixed.cmd`
- optionally create a desktop shortcut

## Launch

After setup, run:

```powershell
.\FlatCAM-Fixed.cmd
```

## Notes

The upstream `requirements.txt` contains `gdal`, but Windows pip commonly tries
to compile it from source and fails with missing files like `gdal.h`. This setup
skips `gdal` by default and keeps `rasterio`, which is what FlatCAM uses for the
image tool in this fork.

To force a full upstream dependency install, run:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\windows\Setup-FlatCAM.ps1 -InstallGdal
```
