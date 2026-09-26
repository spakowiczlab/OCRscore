# Manuscript figure notebooks.
#
# From dissemination/manuscript/:
#   rmarkdown::render("figure_1.Rmd")   # tracked data only
#   rmarkdown::render("figure_4.Rmd")   # tracked Excel only
#   rmarkdown::render("figure_3.Rmd")   # needs external TCGA/PCAWG/many-cancers
#   rmarkdown::render("Supplement.Rmd") # needs many-cancers
#
# For figures 3 / supplement, copy ../../paths.example.json → ../../paths.json
# and set data_root (see repository README).

message(
  "Knit the figure_*.Rmd notebooks directly.\n",
  "Figure 1 and 4 use tracked inputs under data/ and exploratory/data/.\n",
  "Figure 3 and Supplement need a local data_root (paths.json)."
)
