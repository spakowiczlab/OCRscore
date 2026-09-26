#' Load pan-cancer OCR scores vs Buffa hypoxia score
#'
#' Reads precomputed average OXPHOS / ETC gene-expression tables
#' (`*OXPHOS*MaxLimitsall*.txt`) and returns sample-level Buffa scores
#' with OCR score (`AvgExpr`).
#'
#' @param dir Directory containing the many-cancers correlation tables.
#' @return A data frame with columns sampleID, BUFFA_HYPOXIA_SCORE,
#'   AvgExpr (OCR score), cancer, and pos (Buffa > 0).
loadOCRscores <- function(dir) {
  x <- data.frame(files = list.files(dir, full.names = TRUE)) %>%
    filter(grepl("\\.txt", files)) %>%
    filter(grepl("MaxLimitsall", files))

  ocr.files <- x %>%
    filter(grepl("OXPHOS", files))

  ocr <- lapply(X = ocr.files$files, readAndFilter) %>%
    bind_rows() %>%
    mutate(pos = if_else(BUFFA_HYPOXIA_SCORE > 0,
                         true = "positive",
                         false = "negative"))

  return(ocr)
}

# Backward-compatible alias (historical name: mitoscore)
loadMitoscores <- loadOCRscores
