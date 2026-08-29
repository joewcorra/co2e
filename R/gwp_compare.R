#' Compare a gas's GWP across IPCC Assessment Reports
#'
#' @param gas A single gas identifier (e.g. `"HFC-134a"`).
#' @param horizon Time horizon in years: one of `20`, `100`, `500`.
#'   Defaults to `100`.
#'
#' @return A tibble with one row per assessment report that reports a value
#'   for `gas` at the given horizon, columns `ar` and `gwp`.
#'
#' @examples
#' gwp_compare("CFC-11")
#'
#' @importFrom dplyr .data
#' @export
gwp_compare <- function(gas, horizon = 100) {
  co2e::gwp_values |>
    dplyr::filter(
      .data$gas_id == gas,
      .data$horizon == !!horizon
    ) |>
    dplyr::select("ar", "gwp") |>
    dplyr::arrange(.data$ar)
}
