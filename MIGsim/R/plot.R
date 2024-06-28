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

contrast_df <- function(template, simulated) {
  bind_rows(
    template = pivot_experiment(template),
    simulated = pivot_experiment(simulated),
    .id = "source"
  )
}

#' @importFrom dplyr filter
#' @importFrom ggplot2 geom_boxplot
#' @export
contrast_boxplot <- function(
    template, simulated, facet_fmla = . ~ reorder(treatment, -value),
    n_plot = 30) {
  # abundant features
  ix <- order(rowSums(assay(template)), decreasing = TRUE)
  top_features <- head(rownames(template)[ix], n_plot)

  # show side by side
  contrast_df(template, simulated) |>
    filter(feature %in% top_features) |>
    ggplot() +
    geom_vline(xintercept = 0) +
    geom_boxplot(aes(value, reorder(feature, value), fill = source)) +
    facet_grid(facet_fmla)
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
#' @importFrom dplyr everything bind_rows
#' @export
correlation_hist <- function(e_true, e_sim) {
  bind_rows(
    cor_true = as.numeric(cor(t(assay(e_true)))),
    cor_sim = as.numeric(cor(t(assay(e_sim))))
  ) |>
    data.frame() |>
    reshape(
      varying = list(c("cor_true", "cor_sim")),
      v.names = "value",
      timevar = "method",
      times = c("cor_true", "cor_sim"),
      direction = "long"
    ) |>
    ggplot() +
    geom_histogram(aes(value, fill = method), position = "identity", alpha = 0.75) +
    scale_y_continuous(expand = c(0, 0, .1, 0))
}

reshape_rho <- function(rho) {
  rho_df <- as.data.frame(rho)
  rho_df$feature1 <- rownames(rho_df)
  rho_long <- reshape(
    rho_df, 
    varying = list(names(rho_df)[1:(ncol(rho_df)-1)]), 
    v.names = "value", 
    timevar = "feature2", 
    times = names(rho_df)[1:(ncol(rho_df)-1)], 
    idvar = "feature1", 
    direction = "long"
  )
  rownames(rho_long) <- NULL
  rho_long[, c("feature1", "feature2", "value")]
}

#' @importFrom dplyr mutate
#' @importFrom ggplot2 ggplot geom_tile labs aes theme
#' @importFrom scico scale_fill_scico scale_color_scico
#' @importFrom tibble rownames_to_column
#' @importFrom tidyr pivot_longer
#' @export
correlation_heatmap <- function(rho, feature_order, bins = NULL) {
  if (is.null(bins)) {
    bins <- seq(-1, 1, length.out = 11)
  }

  reshape_rho(rho) |>
    mutate(
      feature1 = factor(feature1, levels = rownames(t1d)[feature_order]),
      feature2 = factor(feature2, levels = rownames(t1d)[feature_order]),
      value = cut(value, bins)
    ) |>
    ggplot() +
      geom_tile(aes(feature1, feature2, fill = value, col = value)) +
      scale_fill_scico_d(palette = "lisbon") +
      scale_color_scico_d(palette = "lisbon") +
      labs(x = expression("Feature"~j), y = expression("Feature"~j^"'"), fill = expression(rho), col = expression(rho)) +
      theme(
        axis.text = element_blank(),
        axis.ticks = element_blank()
      )
}