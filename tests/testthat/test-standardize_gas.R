test_that("standardize_gas() matches an exact gas_id", {
  result <- standardize_gas("HFC-134a")
  expect_equal(result$gas_id, "HFC-134a")
  expect_equal(result$match_type, "gas_id")
})

test_that("standardize_gas() matches gas_id case/format-insensitively", {
  result <- standardize_gas("co2")
  expect_equal(result$gas_id, "CO2")
  expect_equal(result$match_type, "gas_id")
})

test_that("standardize_gas() returns unmatched, not an error, for unrecognized input", {
  result <- standardize_gas("not a real gas")
  expect_true(is.na(result$gas_id))
  expect_equal(result$match_type, "unmatched")
})

test_that("standardize_gas() is vectorized and preserves input order", {
  result <- standardize_gas(c("HFC-134a", "co2", "not a real gas"))
  expect_equal(result$input, c("HFC-134a", "co2", "not a real gas"))
  expect_equal(result$gas_id, c("HFC-134a", "CO2", NA))
  expect_equal(result$match_type, c("gas_id", "gas_id", "unmatched"))
})

test_that("standardize_gas() matches a documented synonym", {
  result <- standardize_gas("Trichlorofluoromethane")
  expect_equal(result$gas_id, "CFC-11")
  expect_equal(result$match_type, "synonym")
})

test_that("standardize_gas() does not resolve ASHRAE R-number names (blends deferred)", {
  # R-134a is the ASHRAE refrigerant number for HFC-134a. Blend/R-number
  # synonyms are an intentionally deferred feature (see gases$is_blend),
  # so this should stay unmatched rather than silently start passing.
  result <- standardize_gas("R-134a")
  expect_equal(result$match_type, "unmatched")
})
