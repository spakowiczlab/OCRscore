# Exploratory analyses

This folder contains **drafts, alternative figure versions, and side analyses**
that informed the OCR score / hypoxia manuscript. They are retained for
transparency but are **not** the frozen scripts for published panels.

For reviewer reproduction of manuscript figures, use
[`../manuscript/`](../manuscript/) instead.

## Notable contents

| Path | Role |
|------|------|
| `scripts/raincloud-tcga-buffa.Rmd`, `scripts/buffa_normalTissue_plot.Rmd` | Drafts that became **Figure 1** (active script: `manuscript/figure_1.Rmd`) |
| `scripts/Fig2_*.Rmd` | Early Buffa–OCR exploratory plots |
| `scripts/Fig3_buffa-mitochondrial-oxygen-demand.Rmd` | Mixed / longer draft that preceded the cleaned `manuscript/figure_3.Rmd` |
| `scripts/Fig4_*.Rmd`, `scripts/core_vs_supernumerary.Rmd` | Draft subunit enrichment visuals and tallies |
| `scripts/archive-from-manuscript/` | Snapshots of manuscript notebooks before OCR-score cleanup |
| `data/Subunit OS 11242021.xlsx` | Curated subunit OS table used by `manuscript/figure_4.Rmd` |
| `data/TableS1_signature-gene-sets.csv` | Gene lists for OCR / biogenesis / mitophagy / core sets |
| `figures/` | PNG/SVG outputs from exploratory runs |

Many scripts expect lab-internal data paths (`paths$box` / `paths$tdrive`).
See the repository README section on reproducibility blockers.
