# _targets.R file
library(targets)
user.funs <- list.files("R", full.names = T)
lapply(user.funs, function(x) source(x))
source("../exploratory/scripts/00-paths.R")
# source("../exploratory/scripts/00-paths.R")
options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse", "tmesig", "readxl"))
list(
  tar_target(
    many_cancers_dir,
    file.path(paths$box, "data", "many-cancers"),
    format = "file"
  ),
  tar_target(
    pcawg_dir,
    file.path(paths$box, "data", "pancan_pcawg_2020"),
    format = "file"
  ),
  tar_target(
    tcga_dir,
    file.path(paths$box, "data", "tcga-expression"),
    format = "file"
  ),
  tar_target(
    mitoscores,
    loadMitoscores(many_cancers_dir)
  ),
  tar_target(
    pcawg_mir_buffa,
    loadAndFormatPCAWG(pcawg_dir)
  ),
  tar_target(
    scores_across_cancers,
    loadManyScores(many_cancers_dir)
  ),
  tar_target(
    tcga_genes_buffa,
    loadAndFormatTCGA(tcga_dir)
  ),
  tar_target(
    plotdat_scores_for_lm,
    formatForSmooth(scores_across_cancers)
  ),
  tar_target(
    integrated_TCGA_PCAWG,
    bind_rows(pcawg_mir_buffa, tcga_genes_buffa)
  ),
  tar_target(
    F4_OS_file,
    "../exploratory/data/Subunit OS 11242021.xlsx",
    format = "file"
  ),
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