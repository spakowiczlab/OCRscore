# _targets.R — reproducible pipeline for manuscript computational figures
#
# Run from the manuscript/ directory:
#   source("start-here.R")
# or:
#   targets::tar_make()
#
# Required external data roots are configured via paths.json (see paths.example.json).

library(targets)

user.funs <- list.files("R", full.names = TRUE, pattern = "\\.R$")
lapply(user.funs, source)

# Resolve data paths: prefer local paths.json, then example template guidance
source("R/setup_paths.R")
paths <- setup_paths()

options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "tmesig", "readxl"))

list(
  # ---- Input directories / files ----
  tar_target(
    many_cancers_dir,
    file.path(paths$data_root, "many-cancers"),
    format = "file"
  ),
  tar_target(
    pcawg_dir,
    file.path(paths$data_root, "pancan_pcawg_2020"),
    format = "file"
  ),
  tar_target(
    tcga_dir,
    file.path(paths$data_root, "tcga-expression"),
    format = "file"
  ),
  tar_target(
    F4_OS_file,
    file.path("..", "exploratory", "data", "Subunit OS 11242021.xlsx"),
    format = "file"
  ),

  # ---- OCR score & related pathway averages vs Buffa (multi-cancer) ----
  tar_target(
    ocrscores,
    loadOCRscores(many_cancers_dir)
  ),
  # Alias retained so older notebooks that tar_load(mitoscores) still work
  tar_target(
    mitoscores,
    ocrscores
  ),
  tar_target(
    scores_across_cancers,
    loadManyScores(many_cancers_dir)
  ),
  tar_target(
    plotdat_scores_for_lm,
    formatForSmooth(scores_across_cancers)
  ),

  # ---- TCGA genes + PCAWG miR-210 vs Buffa ----
  tar_target(
    pcawg_mir_buffa,
    loadAndFormatPCAWG(pcawg_dir)
  ),
  tar_target(
    tcga_genes_buffa,
    loadAndFormatTCGA(tcga_dir)
  ),
  tar_target(
    integrated_TCGA_PCAWG,
    bind_rows(pcawg_mir_buffa, tcga_genes_buffa)
  ),

  # ---- Figure 4: core vs supernumerary OS enrichment (permutation) ----
  tar_target(
    F4_OS_data,
    read_xlsx(F4_OS_file, na = "N/A")
  ),
  tar_target(
    original_data,
    tallyArms(F4_OS_data)
  ),
  tar_target(
    comparison_data,
    make_comparison_data(F4_OS_data)
  )
)
