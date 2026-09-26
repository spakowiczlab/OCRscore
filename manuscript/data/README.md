# Manuscript Figure 1 inputs (lightweight)

These files are **intentionally small** so Figure 1 can be regenerated without
the full `targets` pipeline or T-drive / Box expression trees.

| File | Panel | Notes |
|------|-------|-------|
| `fig1a_buffa_tcga.rds` (+ `.csv`) | A | Sample-level Buffa scores by TCGA cancer type. Tracked. |
| `fig1b_buffa_lung.csv` | B | Lung subset (`source`, `buffa.score`, labels). Built from `buffa_avgZscore.csv`. |
| `buffa_avgZscore.csv` | B (optional) | Full lab export; `figure_1.Rmd` will use this if the slim lung file is absent. |

Figure notebook: [`../figure_1.Rmd`](../figure_1.Rmd).
