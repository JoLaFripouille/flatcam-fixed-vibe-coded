# Visual changelog

This file tracks user-visible changes with dated screenshot evidence.

## 2026-05-14 - KiCad Edge.Cuts internal cutout fix

Folder: [`screenshots/2026-05-14-cutout-fix`](screenshots/2026-05-14-cutout-fix)

### Problem

FlatCAM Cutout generated the toolpath on the wrong side for internal triangular
cutouts when the outside board profile and internal openings were imported from
the same KiCad `Edge.Cuts` Gerber.

![Wrong side internal cutouts](screenshots/2026-05-14-cutout-fix/v0-before-wrong-side-internal-cutouts.png)

### First patch regression

The first implementation recovered internal rings but selected both sides of the
buffered Gerber strokes, causing double cuts around the same contours.

![Double sided cut regression](screenshots/2026-05-14-cutout-fix/v1-regression-double-sided-cut.png)

### Final behavior

The final implementation chooses one cutout ring per detected contour:

- largest contour: outside board profile
- smaller contours: internal openings

![Fixed internal cutouts result](screenshots/2026-05-14-cutout-fix/v2-fixed-single-sided-internal-cutouts.png)

## Screenshot naming convention

Use this pattern:

`YYYY-MM-DD-short-topic/vN-short-description.png`

Examples:

- `2026-05-14-cutout-fix/v0-before-wrong-side-internal-cutouts.png`
- `2026-05-14-cutout-fix/v1-regression-double-sided-cut.png`
- `2026-05-14-cutout-fix/v2-fixed-single-sided-internal-cutouts.png`

Use `v0` for the initial problem, `v1`, `v2`, etc. for visible iterations.
