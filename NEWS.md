# co2e 0.1.0

* Initial release.
* `gwp()` looks up Global Warming Potential values by gas, IPCC Assessment
  Report (AR4-AR6), and time horizon (20, 100, 500 years).
* `as_co2e()` converts a mass of gas to CO2-equivalent.
* `gwp_compare()` compares a gas's GWP across assessment reports.
* `standardize_gas()` maps non-canonical gas names to canonical `gas_id`
  values using documented naming variants (no fuzzy matching).
* Bundled datasets: `gwp_values`, `gases`, `gas_synonyms`, with
  source-by-source provenance in `vignette("provenance")`.
