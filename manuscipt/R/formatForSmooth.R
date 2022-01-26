formatForSmooth <- function(cancer.scores){
  mean.buffa <- 
    cancer.scores %>%
    group_by(cancer) %>%
    summarize(mean = mean(BUFFA_HYPOXIA_SCORE)) %>%
    mutate(`Buffa Category` = if_else(mean > 0,
                                      true = "HB",
                                      false = "LB")) %>%
    mutate(cancer = fct_reorder(cancer, mean))
  
  cmb <- 
    cancer.scores %>%
    full_join(mean.buffa) %>%
    mutate(cancer = fct_reorder(cancer, mean))
  
  cmbl <- 
    cmb %>%
    select(-mean) %>%
    gather(key = "signature", value = "score", 
           -BUFFA_HYPOXIA_SCORE,
           -cancer,
           -pos,
           -`Buffa Category`,
           -sampleID)
  
  return(cmbl)
}