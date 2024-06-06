
#' @importFrom mixOmics block.splsda plotIndiv
#' @export
exper_splsda <- function(exper, y_var = "Category") {
  x <- map(exper, ~ t(assay(.)))
  y <- colData(exper[[1]])[[y_var]]
  block.splsda(x, y)
}
