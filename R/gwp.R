#' Look up a greenhouse gas's Global Warming Potential
#'
#' Returns the GWP for one or more gases from a given IPCC Assessment Report
#' and time horizon. Vectorized over `gas`.
#'
#' @param gas Character vector of gas identifiers (e.g. `"HFC-134a"`). Must
#'   match `gases$gas_id` exactly — use [standardize_gas()] first if your
#'   input data uses non-canonical names.
#' @param ar Assessment report: one of `"AR4"`, `"AR5"`, `"AR6"`.
#' @param horizon Time horizon in years: one of `20`, `100`, `500`.
#'
#' @return A numeric vector the same length as `gas`. Returns `NA` with a
#'   warning for any gas/AR/horizon combination not present in `gwp_values`.
#'
#' @examples
#' gwp("HFC-134a", ar = "AR6", horizon = 100)
#' gwp(c("CO2", "CH4", "HFC-32"), ar = "AR5", horizon = 100)
#'
#' @export
gwp <- function(gas, ar = "AR6", horizon = 100) {
  lookup <- tibble::tibble(
    gas_id = gas,
    ar = ar,
    horizon = horizon
  ) |>
    dplyr::left_join(
      co2e::gwp_values,
      by = c("gas_id", "ar", "horizon")
    )

  unmatched <- lookup$gas_id[is.na(lookup$gwp)]
  if (length(unmatched) > 0) {
    warning(
      "No GWP found for: ", paste(unique(unmatched), collapse = ", "),
      " (ar = ", unique(ar), ", horizon = ", unique(horizon), ")"
    )
  }

  lookup$gwp
}
