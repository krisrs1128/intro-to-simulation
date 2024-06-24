#' @importFrom SummarizedExperiment assay
#' @export
batch_correct <- function(exper, method = "ruv", ...) {
  if (method == "ruv") {
    x <- ruv_correct(exper, ...)
  } else if (method == "combat") {
    x <- combat_correct(exper, ...)
  }
  assay(exper) <- t(x)
  exper
}

#' @importFrom ggplot2 ggplot aes geom_hline geom_vline facet_wrap geom_point
#' @importFrom mixOmics pca
#' @importFrom dplyr bind_cols
#' @export
pca_batch <- function(exper, facet = TRUE) {
  pca_res <- pca(t(assay(exper)))
  p <- bind_cols(pca_res$variates$X, data.frame(colData(exper))) |>
    ggplot(aes(PC1, PC2, col = factor(treatment))) +
    geom_hline(yintercept = 0, linewidth = 0.7, col = "#0c0c0c") +
    geom_vline(xintercept = 0, linewidth = 0.7, col = "#0c0c0c")

  if (facet) {
    p <- p + facet_wrap(~batch) +
      geom_point(size = 2)
  } else {
    p <- p + geom_point(aes(shape = batch), size = 2)
  }
  p
}

#' @importFrom SummarizedExperiment colData assay
#' @importFrom insight check_if_installed
ruv_correct <- function(exper, alpha = 0.05, k = 10) {
  check_if_installed("ruv", "to apply RUV-III correction. Please install this package using install.packages('ruv').")
  trt_p <- apply(assay(exper), 1, FUN = function(x) {
    res.lm <- lm(x ~ treatment + batch, data = colData(exper))
    summary(res.lm)$coefficients[2, 4]
  }) |>
    p.adjust(method = "fdr")

  corrected <- ruv::RUVIII(t(assay(exper)), colData(exper)$sample, trt_p > alpha, k = k)
  rownames(corrected) <- colnames(exper)
  corrected
}

#' @importFrom insight check_if_installed
combat_correct <- function(exper) {
  check_if_installed("sva", "to apply ComBat correction. Please run BiocManager::install('sva') to install this package. You may first need to install BiocManager using install.packages('BiocManager').")
  t(sva::ComBat(
    assay(exper),
    batch = exper$batch,
    par.prior = F, prior.plots = F
  ))
}
