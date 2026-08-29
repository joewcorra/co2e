library(dplyr)
library(tidyr)
library(readr)

# ---- Read source data ----
# Sources (see individual CSV headers / package vignette for full provenance):
#   - gwp_shortlist_epa.csv:   EPA/data.gov IPCC AR4-AR6 GWPs, doi:10.23719/1529821,
#                              plus AR6 methane fossil/non-fossil rows from GHG
#                              Protocol Global Warming Potential Values (Aug 2024)
#   - gas_identity.csv:        formula/CAS from IPCC AR6 WGI Ch.7 SM Table 7.SM.7
#                              (chrisroadmap/ar6 CSV mirror); gas_group assigned manually
#   - gas_synonyms_seed.csv:   documented naming variants from GHG Protocol footnotes,
#                              AR6 Table 7.SM.7, and EPA/data.gov naming

gwp_wide <- read_csv("data-raw/gwp_shortlist_epa.csv", show_col_types = FALSE)
gas_identity <- read_csv("data-raw/gas_identity.csv", show_col_types = FALSE)
gas_synonyms <- read_csv("data-raw/gas_synonyms_seed.csv", show_col_types = FALSE)

# ---- Build gwp_values (long format: one row per gas x AR x horizon) ----

gwp_values <- gwp_wide |>
  select(-epa_name) |>
  pivot_longer(
    cols = -c(gas_id, source),
    names_to = c("ar", "horizon"),
    names_sep = "-",
    values_to = "gwp"
  ) |>
  mutate(
    horizon = as.integer(horizon)
  ) |>
  filter(!is.na(gwp)) |>
  relocate(gas_id, ar, horizon, gwp, source)

# ---- Build gases (identity table) ----

gases <- gas_identity |>
  mutate(
    is_blend = FALSE  # no blends in scope yet; all shortlist entries are single substances
  ) |>
  select(gas_id, formula, cas, gas_group, is_blend)

# ---- Build gas_synonyms ----
# Combine the documented naming-variant seed file with each gas's EPA/data.gov name

epa_name_synonyms <- gwp_wide |>
  distinct(gas_id, epa_name) |>
  mutate(
    synonym_type = "epa_name",
    note = "EPA/data.gov Federal LCA Commons name"
  ) |>
  rename(synonym = epa_name)

gas_synonyms <- bind_rows(
  gas_synonyms,
  epa_name_synonyms
) |>
  distinct(gas_id, synonym, .keep_all = TRUE)

# ---- Save as package data ----

usethis::use_data(gwp_values, overwrite = TRUE)
usethis::use_data(gases, overwrite = TRUE)
usethis::use_data(gas_synonyms, overwrite = TRUE)
