#' Global Warming Potential values by gas, assessment report, and horizon
#'
#' Long-format lookup table: one row per gas x IPCC Assessment Report x time
#' horizon.
#'
#' @format A tibble with columns:
#' \describe{
#'   \item{gas_id}{Canonical gas identifier, joins to `gases$gas_id`.}
#'   \item{ar}{Assessment report: `"AR4"`, `"AR5"`, or `"AR6"`.}
#'   \item{horizon}{Time horizon in years: `20`, `100`, or `500`.}
#'   \item{gwp}{Global Warming Potential (dimensionless, relative to CO2).}
#'   \item{source}{Citation for this row's value.}
#' }
#' @source EPA/data.gov IPCC AR4-AR6 GWPs, doi:10.23719/1529821; AR6 methane
#'   fossil/non-fossil split from GHG Protocol Global Warming Potential
#'   Values (August 2024).
"gwp_values"

#' Gas identity reference table
#'
#' One row per substance covered by the package.
#'
#' @format A tibble with columns:
#' \describe{
#'   \item{gas_id}{Canonical gas identifier.}
#'   \item{formula}{Chemical formula.}
#'   \item{cas}{CAS Registry Number.}
#'   \item{gas_group}{One of `"HFC"`, `"HCFC"`, `"CFC"`, `"halon"`, `"PFC"`,
#'     `"other"`.}
#'   \item{is_blend}{Logical; always `FALSE` in the current release (blends
#'     are not yet in scope).}
#' }
#' @source Formula and CAS from IPCC AR6 WGI Chapter 7 Supplementary
#'   Material, Table 7.SM.7.
"gases"

#' Gas name synonyms
#'
#' Alternate names each gas is known by, for use with [standardize_gas()].
#'
#' @format A tibble with columns:
#' \describe{
#'   \item{gas_id}{Canonical gas identifier, joins to `gases$gas_id`.}
#'   \item{synonym}{An alternate name.}
#'   \item{synonym_type}{One of `"common_name"`, `"ar_naming_variant"`,
#'     `"formatting_variant"`, `"epa_name"`.}
#'   \item{note}{Free-text provenance/context for this synonym.}
#' }
#' @source Documented naming variants from GHG Protocol Global Warming
#'   Potential Values (August 2024) footnotes, IPCC AR6 Table 7.SM.7, and
#'   EPA/data.gov naming.
"gas_synonyms"
