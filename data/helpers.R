
# Plot histogram for toy data
exper_histogram <- function(exper) {
  pivot_experiment(exper) |>
    ggplot() +
      geom_histogram(
        aes(value, fill = group), 
        position = "identity", alpha = 0.8
      ) +
      facet_wrap(~ feature)
}

# Plot time for toy data
exper_lineplot <- function(exper) {
  pivot_experiment(exper) |>
    ggplot() +
      geom_point(aes(time, value, color = group)) +
      facet_wrap(~ feature) +
      ylim(-2, 3)
}

splsda_fit <- function(exper, outcome_var = "outcome2", ncomp = 5, keepX = NULL) {
  if (is.null(keepX)) {
    keepX <- rep(30, ncomp)
  }

  fit <- splsda(t(assay(exper)), colData(exper)$outcome2, ncomp = ncomp, keepX = keepX)
  errs <- perf(fit, nrepeat = 10, folds = 5, auc = TRUE)
  list(auc = errs$auc, fit = fit)
}