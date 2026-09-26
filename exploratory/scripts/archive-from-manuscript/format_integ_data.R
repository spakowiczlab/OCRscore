format_integ_data <- function(plot.in, MIR210){
  integ.data <- plot.in %>%
    filter(cancer != "kirc") %>%
    mutate(buffa.score = BUFFA_HYPOXIA_SCORE,
           log.counts = log(genecount + 1)) %>%
    bind_rows(MIR210) %>%
    filter(Hugo_Symbol == "MIR210" | !is.na(BUFFA_HYPOXIA_SCORE))
}