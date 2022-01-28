make_comparison_data <- function(x){
  B <- 1000
  
  # Pre-allocate memory
  out <- list()
  
  # Randomize the "OS outcome" variable and count
  for(i in 1:B) {
    y <- 
      x %>%
      mutate(`OS outcome` = sample(`OS outcome`))
    
    out[[i]] <- tallyArms(y)
  }
  
  outdf <- bind_rows(out)
  return(outdf)
}