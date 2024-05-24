#' Plot histogram for toy data
#' @importFrom scDesigner pivot_experiment
#' @importFrom ggplot2 ggplot geom_histogram aes facet_wrap
#' @export
exper_histogram <- function(exper) {
  pivot_experiment(exper) |>
    ggplot() +
    geom_histogram(
      aes(value, fill = group),
      position = "identity", alpha = 0.8
    ) +
    facet_wrap(~feature)
}

#' Plot time for toy data
#' @importFrom ggplot2 geom_point ylim
#' @export
exper_lineplot <- function(exper) {
  pivot_experiment(exper) |>
    ggplot() +
    geom_point(aes(time, value, color = group)) +
    facet_wrap(~feature) +
    ylim(-2, 3)
}

#' @importFrom SummarizedExperiment assay
#' @export
select_features <- function(exper, qmin = 0.9, qmax = 1, summary_fun = median) {
  summaries <- apply(assay(exper), 1, summary_fun)
  quantiles <- quantile(summaries, c(qmin, qmax))
  ix <- (summaries > quantiles[1]) & (summaries < quantiles[2])
  rownames(exper)[ix]
}

#' @importFrom ggplot2 ggplot scale_y_continuous
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr everything bind_rows
#' @importFrom
#' @export
correlation_hist <- function(e_true, e_sim) {
  bind_rows(
    cor_true = as.numeric(cor(t(assay(e_true)))),
    cor_sim = as.numeric(cor(t(assay(e_sim))))
  ) |>
    pivot_longer(everything(), names_to = "method") |>
    ggplot() +
    geom_histogram(aes(value, fill = method), position = "identity", alpha = 0.75) +
    scale_y_continuous(expand = c(0, 0, .1, 0))
}
