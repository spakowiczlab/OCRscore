# _targets.R file
library(targets)
source("R/format_integ_data.R")
# source("../exploratory/scripts/00-paths.R")
options(tidyverse.quiet = TRUE)
tar_option_set(packages = c("tidyverse"))
list(
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