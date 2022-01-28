tallyArms <- function(df) {
  df %>%
    group_by(`Core/Supernumerary`, `OS outcome`) %>%
    summarize(n = n()) %>%
    ungroup() %>%
    mutate(core.out = paste(`Core/Supernumerary`, `OS outcome`, sep = ".")) %>%
    select(core.out, n) %>%
    spread(key = core.out, value = n)
}
