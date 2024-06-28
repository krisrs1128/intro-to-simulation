#' @importFrom purrr map_dfr
#' @importFrom tidyr pivot_longer separate pivot_wider
#' @importFrom tidyselect everything
#' @importFrom dplyr mutate arrange group_by
#' @export
reshape_correlations <- function(rho_hat) {
  comparison <- data.frame(
    truth = map_dfr(example_rho, ~ c(.), .id = "source"),
    banded = map_dfr(rho_hat[["banded"]], ~ c(.), .id = "source"),
    block = map_dfr(rho_hat[["block"]], ~ c(.), .id = "source"),
    scale_free = map_dfr(rho_hat[["scale_free"]], ~ c(.), .id = "source"),
    small_world = map_dfr(rho_hat[["small_world"]], ~ c(.), .id = "source"),
    erdos_renyi = map_dfr(rho_hat[["erdos_renyi"]], ~ c(.), .id = "source")
  )
  colnames(comparison)[1:5] <- c("block.truth", "scale_free.truth", "banded.truth", "small_world.truth", "erdos_renyi.truth")

  comparison |>
    pivot_longer(everything()) |>
    separate(name, c("structure", "estimator"), sep = "\\.") |>
    group_by(estimator) |>
    arrange(structure) |>
    mutate(ix = row_number()) |>
    pivot_wider(names_from = "estimator") |>
    pivot_longer(se:lw, names_to = "method") |>
    mutate(
      structure = case_when(
        structure == "banded" ~ "Banded",
        structure == "block" ~ "Block",
        structure == "erdos_renyi" ~ "Erdos Renyi",
        structure == "scale_free" ~ "Scale-Free",
        structure == "small_world" ~ "Small-World"
      ),
      method = case_when(
        method == "lw" ~ "Ledoit-Wolf",
        method == "se" ~ "SpiecEasi"
      )
    )
}

#' @export
#' @importFrom dplyr bind_rows
#' @importFrom glue glue
subset_correlated <- function(x, top_cors) {
  pairs_data <- list()
  for (i in seq_len(nrow(top_cors))) {
    feature1 <- rownames(x)[top_cors[i, 1]]
    feature2 <- rownames(x)[top_cors[i, 2]]
    pairs_data[[i]] <- data.frame(
      feature1 = x[feature1, ],
      feature2 = x[feature2, ],
      pair = rep(glue("{feature1}-{feature2}"), ncol(x)),
      correlation = cor(x[feature1, ], x[feature2, ])
    )
  }

  res <- bind_rows(pairs_data)
  rownames(res) <- NULL
  res
}