# Manuscript computational analyses for OCRscore

Reviewer-facing notebooks that regenerate computational manuscript figures.
**No `{targets}` pipeline** — each notebook loads what it needs directly.

## Quick start

| Figure | Command (from `manuscript/`) | Data needed |
|------|------------------------------|-------------|
| **1** | `rmarkdown::render("figure_1.Rmd")` | Tracked under [`data/`](data/) |
| **4** | `rmarkdown::render("figure_4.Rmd")` | Tracked Excel in `exploratory/data/` |
| **3** | `rmarkdown::render("figure_3.Rmd")` | External `data_root` via [`../paths.json`](../paths.example.json) |
| **Supp** | `rmarkdown::render("Supplement.Rmd")` | External `many-cancers/` |

| Manuscript item | Script | Output |
|-----------------|--------|--------|
| **Figure 1A–B** | [`figure_1.Rmd`](figure_1.Rmd) | `figures/Fig1_buffa-rainclouds.png` (5 × 6.5 in) |
| **Figure 3A–C** | [`figure_3.Rmd`](figure_3.Rmd) | `figures/Fig3*.png` |
| **Figure 4** (*P* values) | [`figure_4.Rmd`](figure_4.Rmd) | `figures/Fig4_core-supernumerary_permutation_pvalues.csv` |
| **Supplement** | [`Supplement.Rmd`](Supplement.Rmd) | `figures/Supp_OCR-biogen-mitophagy_lm_facet.png` |

Helpers live in [`R/`](R/). An archived `{targets}` `_targets.R` (no longer used)
is under `exploratory/scripts/archive-from-manuscript/`.

## OCR score vs historical "mitoscore" name

Prefer OCR score wording in figures. Package API in `{tmesig}` still uses
`calculateMitoscore()` / `inputGenes("Mitoscore")`.

## Dependencies

```r
install.packages(c(
  "tidyverse", "readxl", "ggtext", "jsonlite", "readr",
  "ggdist", "colorspace", "patchwork"
))
devtools::install_github("spakowiczlab/tmesig")  # Fig 3 Buffa on PCAWG
```
