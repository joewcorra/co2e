#' Convert a mass of greenhouse gas to CO2-equivalent
#'
#' @param value Numeric vector of gas quantities (any consistent mass unit).
#' @param gas Character vector of gas identifiers, recycled against `value`.
#' @param ar Assessment report: one of `"AR4"`, `"AR5"`, `"AR6"`.
#' @param horizon Time horizon in years: one of `20`, `100`, `500`.
#'
#' @return A numeric vector of CO2-equivalent quantities, in the same units
#'   as `value`.
#'
#' @examples
#' as_co2e(10, gas = "HFC-134a", ar = "AR6", horizon = 100)
#'
#' @export
as_co2e <- function(value, gas, ar = "AR6", horizon = 100) {
  value * gwp(gas, ar = ar, horizon = horizon)
}
