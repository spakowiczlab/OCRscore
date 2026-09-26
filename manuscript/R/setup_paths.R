#' Resolve data paths for the manuscript targets pipeline.
#'
#' Looks for `paths.json` in the repository root (one level above
#' `manuscript/`). If missing, prints guidance and stops.
#'
#' Expected keys in paths.json:
#'   - data_root: directory containing many-cancers/, pancan_pcawg_2020/,
#'     and tcga-expression/ (or set those paths individually)
#'   - many_cancers, pcawg, tcga: optional overrides
#'
#' For backward compatibility with older Spakowicz-lab configs, also
#' accepts `box` or `tdrive` as synonyms for `data_root` parents
#' (data live under `<box|tdrive>/data/...`).
setup_paths <- function(repo_root = "..") {
  candidates <- c(
    file.path(repo_root, "paths.json"),
    file.path(repo_root, "ocrscore.json"),
    file.path(repo_root, "mitoscore.json")
  )
  jinfo <- candidates[file.exists(candidates)][1]

  if (is.na(jinfo)) {
    stop(
      "No paths.json found. Copy paths.example.json to paths.json ",
      "at the repository root and set data_root to your local data directory.\n",
      "See manuscript/README.md for required data layout.",
      call. = FALSE
    )
  }

  if (!requireNamespace("jsonlite", quietly = TRUE) &&
      !requireNamespace("rjson", quietly = TRUE)) {
    stop("Install jsonlite (preferred) or rjson to read paths.json", call. = FALSE)
  }

  cfg <- if (requireNamespace("jsonlite", quietly = TRUE)) {
    jsonlite::fromJSON(jinfo)
  } else {
    rjson::fromJSON(file = jinfo)
  }

  p <- cfg$paths
  if (is.null(p)) p <- cfg

  data_root <- p$data_root
  if (is.null(data_root) || !nzchar(data_root)) {
    # Legacy layouts: data under <box|tdrive>/data
    parent <- p$box %||% p$tdrive
    if (!is.null(parent) && nzchar(parent)) {
      data_root <- file.path(parent, "data")
    }
  }

  if (is.null(data_root) || !nzchar(data_root)) {
    stop(
      "paths.json must define data_root (or legacy box/tdrive). ",
      "See paths.example.json.",
      call. = FALSE
    )
  }

  list(
    data_root = data_root,
    many_cancers = p$many_cancers %||% file.path(data_root, "many-cancers"),
    pcawg = p$pcawg %||% file.path(data_root, "pancan_pcawg_2020"),
    tcga = p$tcga %||% file.path(data_root, "tcga-expression"),
    # Figure 1B: Buffa scores for TCGA adjacent-normal + GTEx-like lung, etc.
    buffa_normal_file = p$buffa_normal_file %||%
      file.path(data_root, "tcga_normal_tissue", "buffa_avgZscore.csv"),
    # expose legacy names used by some exploratory scripts
    box = dirname(data_root),
    tdrive = dirname(data_root)
  )
}

`%||%` <- function(a, b) if (is.null(a) || !nzchar(a)) b else a
