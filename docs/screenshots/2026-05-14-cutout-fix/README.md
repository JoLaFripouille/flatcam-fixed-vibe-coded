# 2026-05-14 Cutout Fix Screenshots

These screenshots document the visible FlatCAM Cutout behavior while fixing
KiCad `Edge.Cuts` internal openings.

## Versions

- `v0-before-wrong-side-internal-cutouts.png`: original problem, internal
  triangular cutouts are offset on the wrong side.
- `v1-regression-double-sided-cut.png`: first attempted fix, both sides of the
  buffered Gerber stroke are cut.
- `v2-fixed-single-sided-internal-cutouts.png`: reserved for the final clean
  screenshot showing one correct path per contour.

## Related reference

- `candle-tool-management-block-reference.png`: unrelated Candle/FlatCAM G-code
  tool-management issue captured the same morning; kept as context for workshop
  testing but not part of the cutout geometry fix.
