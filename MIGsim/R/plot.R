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
exper_lineplot <- function(exper) {
  pivot_experiment(exper) |>
    ggplot() +
    geom_point(aes(time, value, color = group)) +
    facet_wrap(~feature) +
    ylim(-2, 3)
}
