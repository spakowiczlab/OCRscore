loadAndFormatPCAWG <- function(dir){
  # Read in everything
  
  mirna <- read.table(file.path(dir, "data_mirna.txt"),
                      header = TRUE) 
  
  rna <- read.table(file.path(dir, "data_mrna_seq_fpkm.txt"),
               header = TRUE) 
  
  clin <- read.table(file.path(dir, "data_clinical_sample.txt"),
                     sep = "\t", header = T)

  # Define and remove unwanted samples
  badsamps <- clin %>%
    filter(HISTOLOGY_ABBREVIATION %in% c("Kidney-RCC", "Kidney-ChRCC"))
  
  # Calculate PCAWG buffa
  alt.gene.names <- c("PNP", "HILPDA", "MRGBP", "AK3", "ESRP1", "CTSV")
  
  buffain <- rna %>%
    mutate(Gene = as.character(Hugo_Symbol)) %>%
    dplyr::select(-Hugo_Symbol) %>%
    dplyr::select(-any_of(badsamps$SAMPLE_ID)) %>%
    dplyr::select(-any_of(clin$SAMPLE_ID[is.na(clin$HISTOLOGY_ABBREVIATION)]))
  
  rna.buffa <- calculateBuffa(buffain, c(inputGenes("Buffa"), alt.gene.names))
  
  # Format for the correlations. We only use the MIR correlation for the current fig.
  
  corr.in.mir <- mirna %>%
    column_to_rownames(var = "Hugo_Symbol") %>%
    t() %>%
    as.data.frame() %>%
    rownames_to_column(var = "sample") %>%
    mutate(log.counts = log(`hsa-miR-210-3p` + 1),
           Hugo_Symbol = "MIR210") %>%
    dplyr::select(sample, Hugo_Symbol, log.counts) %>%
    left_join(rna.buffa) %>%
    drop_na(buffa.score)
  
  return(corr.in.mir)

}