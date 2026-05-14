# FlatCAM Fixed Vibe Coded

This repository is a personal fork of FlatCAM / FlatCAM Evo focused on practical
PCB milling fixes tested in a small workshop workflow.

## Upstream

- Upstream source used for this fork: `dwrobel/flatcam`
- Base branch: `mstanciu_Beta_8.995`
- Base commit at fork time: `573707ce Add python3 shebang`

## License

FlatCAM is distributed under the MIT License. This fork keeps the original
`LICENSE` file and copyright notices intact, as required by the license.

## Changes in this fork

### KiCad Edge.Cuts internal cutout handling

The Cutout tool was adjusted for Gerber files that contain both:

- the outside board profile
- internal cutouts, slots, or triangular openings on `Edge.Cuts`

The previous behavior could offset internal cutouts on the wrong side, or cut
both sides of the same internal profile when trying to recover the missing
contours.

The current fix chooses one cutout ring per detected contour:

- the largest contour is treated as the outside board outline
- smaller contours are treated as internal openings

This was tested with a KiCad board containing triangular internal cutouts.

Visual evidence is tracked in [`docs/CHANGELOG_VISUAL.md`](docs/CHANGELOG_VISUAL.md).

## Notes

This fork is not an official FlatCAM release. It is a workshop-tested branch
published so the changes are visible, reproducible, and reusable.

Windows setup helper: [`SETUP_WINDOWS.ps1`](SETUP_WINDOWS.ps1).
Windows installer build helper: [`BUILD_SETUP_EXE.ps1`](BUILD_SETUP_EXE.ps1).
The generated `FlatCAM-Fixed-Setup.exe` includes a portable Python runtime for
regular Windows users.
