loadManyScores <- function(dir){
  x <- data.frame(files = list.files(dir, 
                                     full.names = TRUE)) %>%
    filter(grepl("\\.txt", files)) %>%
    filter(grepl("MaxLimitsall", files))
  
  
  mitophagy.files <- x %>%
    filter(grepl("GOBP_MITOPHAGY", files))
  
  biogen.files <- 
    x %>%
    filter(grepl("BIOGEN", files))
  
  etc.files <- 
    x %>%
    filter(grepl("ELECTRON", files))
  
  mitophagy <- lapply(X = mitophagy.files$files, readAndFilter) %>%
    bind_rows() %>%
    rename("Mitophagy" = "AvgExpr")
  
  biogen <- lapply(X = biogen.files$files, readAndFilter) %>%
    bind_rows() %>%
    rename("Mitochondrial Biogenesis" = "AvgExpr")
  
  etc <- lapply(X = etc.files$files, readAndFilter) %>%
    bind_rows() %>%
    rename("Electron Transport Chain" = "AvgExpr")
  
  comb <- 
    mitophagy %>%
    full_join(biogen) %>%
    full_join(etc) %>%
    mutate(pos = if_else(BUFFA_HYPOXIA_SCORE > 0,
                         true = "positive",
                         false = "negative"),
           cancer = toupper(cancer))
  
  return(comb)
}