loadAndFormatTCGA <- function(dir){
  
  # Find + load files
  split.dirs <- list.files(dir)
  cnames <- gsub("_.*", "", split.dirs)
  names(split.dirs) <- cnames
  
  hypox.df <- lapply(cnames, function(x) read.table(file.path(dir, split.dirs[[x]],
                                                              "data_clinical_supp_hypoxia.txt"),
                                                    header = T) %>%
                       mutate(cancer = x)) %>%
    bind_rows()
  
  entrez.df <- lapply(cnames, function(x) read.table(file.path(dir, split.dirs[[x]],
                                                               "data_RNA_Seq_v2_expression_median.txt"),
                                                     header = T, sep = "\t")) 
  
  # Pull only desired genes - leaving names used by Denko group here for reference
  # genes.provided <- c("PDHK1", "PDhK3", "mir210", "NDUFA4L2")
  genes.aspresent <- c("PDK1", "PDK3", "NDUFA4L2")
  
  # Bring all the pieces together in the format used for the figure
  plotdat.form <- lapply(entrez.df, function(x) x %>% 
                           dplyr::filter(Hugo_Symbol %in% genes.aspresent) %>%
                           dplyr::select(-Entrez_Gene_Id) %>%
                           tidyr::gather(-Hugo_Symbol, key = "PATIENT_ID", value = "genecount")) %>%
    bind_rows() %>%
    mutate(PATIENT_ID = gsub("\\.", "-", gsub("\\.01", "", PATIENT_ID))) %>%
    left_join(hypox.df)%>%
    mutate(PATIENT_ID = gsub("\\.", "-", gsub("\\.01", "", PATIENT_ID))) %>%
    left_join(hypox.df) %>%
    filter(cancer != "kirc") %>%
    mutate(buffa.score = BUFFA_HYPOXIA_SCORE,
           log.counts = log(genecount + 1))
  
  return(plotdat.form)
}