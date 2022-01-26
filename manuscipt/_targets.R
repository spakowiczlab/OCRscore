# _targets.R file
library(targets)
user.funs <- list.files("R", full.names = T)
lapply(user.funs, function(x) source(x))
source("../exploratory/scripts/00-paths.R")
# source("../exploratory/scripts/00-paths.R")
options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse"))
list(
  tar_target(
    many_cancers_dir,
    file.path(paths$box, "data", "many-cancers"),
    format = "file"
  ),
  tar_target(
    scores_across_cancers,
    loadManyScores(many_cancers_dir)
  ),
  tar_target(
    plotdat_scores_for_lm,
    formatForSmooth(scores_across_cancers)
  ),
  tar_target(
    F3B_data_RDS,
    "../exploratory/data/oxic-induced-genes.RDS",
    format = "file"
  ),
  tar_target(
    F3B_mir_file,
    "../exploratory/data/mir210-with-genes.RDS",
    format = "file"
  ),
  tar_target(
    F3B_plot_data,
    readRDS(F3B_data_RDS)
  ),
  tar_target(F3B_mir_data,
             readRDS(F3B_mir_file)),
  tar_target(integ.data, format_integ_data(F3B_plot_data, F3B_mir_data))
)