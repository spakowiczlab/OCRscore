readAndFilter <- function(table) {
  read.table(table) %>%
    select(BUFFA_HYPOXIA_SCORE, AvgExpr) %>%
    rownames_to_column("sampleID") %>%
    mutate(cancer = table) %>%
    mutate(cancer = gsub(pattern = ".*LogExpr_(.*)_AverageGene.*", 
                         replacement = "\\1",
                         x = cancer))
}