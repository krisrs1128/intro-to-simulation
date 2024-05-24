#' Run SPLS-DA and Collect Metrics
#'
#' Wrapper to apply mixOmics' sparse pls discriminant analysis ' on a
#' SummarizedExperiment object.
#'
#' @param exper
#' @param outcome_var
#' @param ncomp
#' @param keepX
#' @param repeat
#' @param folds
#' @return A list with both the CV-averaged AUC and the fitted SPLS-DA object.
#' @export
#' @importFrom mixOmics splsda perf
splsda_fit <- function(exper, outcome_var = "outcome2", ncomp = 2, keepX = NULL, nrepeat = 4, folds = 5) {
  if (is.null(keepX)) {
    keepX <- rep(30, ncomp)
  }

  fit <- splsda(t(assay(exper)), colData(exper)$outcome2, ncomp = ncomp, keepX = keepX)
  errs <- perf(fit, nrepeat = nrepeat, folds = folds, auc = TRUE)
  list(auc = errs$auc[[ncomp]][["AUC.mean"]], fit = fit)
}
