#' Raincloud of Buffa hypoxia scores by group
#'
#' Half-eye + box + jittered points (no gghalves; compatible with ggplot2 4.x).
#'
#' @param df Data frame with columns `score` and `group` (factor or character).
#' @return A ggplot object, coord_flip'ed.
plot_buffa_raincloud <- function(df) {
  ggplot2::ggplot(df, ggplot2::aes(y = score, x = group, color = group, fill = group)) +
    ggdist::stat_halfeye(
      adjust = 0.5,
      width = 0.6,
      justification = -0.2,
      .width = 0,
      point_colour = NA,
      show.legend = FALSE
    ) +
    ggplot2::geom_boxplot(
      width = 0.15,
      outlier.shape = NA,
      alpha = 0.4,
      show.legend = FALSE
    ) +
    ggplot2::geom_point(
      size = 0.9,
      alpha = 0.25,
      position = ggplot2::position_jitter(width = 0.1, height = 0),
      show.legend = FALSE
    ) +
    ggplot2::theme_bw(base_size = 8, base_family = "Arial") +
    ggplot2::theme(axis.text.y = ggplot2::element_text(lineheight = 0.9)) +
    ggplot2::coord_flip() +
    ggplot2::scale_color_viridis_d() +
    ggplot2::scale_fill_viridis_d() +
    ggplot2::labs(y = "Buffa Hypoxia Score", x = "")
}

#' Friendly labels for Figure 1B lung / adjacent-normal categories
lung_buffa_labels <- c(
  "adj.norm-luad" = "Adjacent Normal\nLUAD",
  "adj.norm-lusc" = "Adjacent Normal\nLUSC",
  "lung" = "Healthy Lung",
  "luad-tumor" = "LUAD",
  "lusc-tumor" = "LUSC"
)

#' Format normal/tumor Buffa table for Figure 1B
#'
#' @param buffa Data frame with columns `source` and `buffa.score`
#'   (from buffa_avgZscore.csv or fig1b_buffa_lung.csv).
format_lung_buffa <- function(buffa) {
  tcga_adj <- c(
    "blca", "brca", "cesc", "chol", "coad", "esca", "hnsc", "kich", "kirc",
    "kirp", "lihc", "luad", "lusc", "prad", "read", "stad", "thca", "ucec"
  )

  out <- buffa
  out$source <- ifelse(
    out$source %in% tcga_adj,
    paste0("adj.norm-", out$source),
    as.character(out$source)
  )
  out <- out[out$source %in% names(lung_buffa_labels), , drop = FALSE]
  out$label <- unname(lung_buffa_labels[out$source])
  means <- tapply(out$buffa.score, out$label, mean)
  out$group <- factor(out$label, levels = names(sort(means, decreasing = TRUE)))
  out$score <- out$buffa.score
  out
}
