# co2e

<!-- badges: start -->
[![R-CMD-check](https://github.com/joewcorra/co2e/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/joewcorra/co2e/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Curated IPCC Global Warming Potential (GWP) values, gas name
standardization, and CO2-equivalent conversion for R.

Values are verified against final published IPCC source tables (AR4-AR6)
rather than taken from secondary compilations. See
`vignette("provenance", package = "co2e")` for source-by-source notes.

## Installation

```r
# install.packages("devtools")
devtools::install_github("joewcorra/co2e")
```

## Usage

```r
library(co2e)

# Convert a mass of gas to CO2-equivalent
as_co2e(10, gas = "HFC-134a", ar = "AR6", horizon = 100)

# Look up a GWP directly
gwp(c("CO2", "CH4", "HFC-32"), ar = "AR6", horizon = 100)

# Compare a gas's GWP across assessment reports
gwp_compare("CFC-11")

# Standardize non-canonical gas names before lookup
standardize_gas(c("HFC-134a", "Trichlorofluoromethane", "not a real gas"))
```

`standardize_gas()` matches against canonical gas IDs and documented
naming variants (IUPAC/common names, per-report naming changes, and
EPA/data.gov naming). Refrigerant blends and ASHRAE R-number naming (e.g.
`"R-134a"`) are not yet supported and will return `"unmatched"`.

## Scope

- Single substances only — no refrigerant blends yet.
- GWP values for the 20-, 100-, and 500-year time horizons across AR4,
  AR5, and AR6.

## License

MIT © Joe Corra
