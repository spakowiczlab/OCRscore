loadMitoscores <- function(dir){
  x <- data.frame(files = list.files(file.path(paths$box, "data", "many-cancers"), 
                                     full.names = TRUE)) %>%
    filter(grepl("\\.txt", files)) %>%
    filter(grepl("MaxLimitsall", files))
  
  
  mitoscore.files <- x %>%
    filter(grepl("OXPHOS", files))
  
  mitoscore <- lapply(X = mitoscore.files$files, readAndFilter) %>%
    bind_rows()  %>%
    mutate(pos = if_else(BUFFA_HYPOXIA_SCORE > 0,
                         true = "positive",
                         false = "negative"))
  
  return(mitoscore)
}