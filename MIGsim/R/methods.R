#' Run SPLS-DA and Collect Metrics
#'
#' Wrapper to apply mixOmics' sparse pls discriminant analysis ' on a
#' SummarizedExperiment object.
#'
#' @param exper The SummarizedExperiment on which to run spls-da.
#' @param outcome_var The response variable from exper's colData slot.
#' @param ncomp The number of components to use in the SPLS-DA.
#' @param keepX The number of variables to include in each component.
#' @param repeat The number of repeats used for evaluating performance with CV.
#' @param folds The number of folds used for evaluating performance with CV.
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

matnorm <- \(n, m, ...) matrix(rnorm(n * m, ...), n, m)

#' Generate Random Spline
#'
#' This generates random spline functions. It is used in the toy nonlinear
#' dataset created in `demo_spline()`. This is not necessary for the essential
#' multimedia workflow, it is only exported for potential independent interest.
#'
#' @seealso demo_spline
#' @examples
#' x <- seq(-2, 2, length.out = 100)
#' f <- spline_fun(sd = 0.3)
#' fx <- f(x)
#' plot(x, fx[, 1])
#' @importFrom splines ns
#' @export
spline_fun <- function(D = 2, knots = NULL, h_ix = 1:10, ...) {
  if (is.null(knots)) {
    knots <- seq(-4, 4, length.out = 5)
  }

  h_dim <- splines::ns(h_ix, knots = knots, intercept = TRUE)
  B <- matnorm(D, ncol(h_dim))
  function(x) {
    H <- splines::ns(x, knots = knots, intercept = TRUE)
    scale(H %*% t(B) + rnorm(nrow(H), ...))
  }
}
