test_that("as_co2e() multiplies value by the looked-up gwp", {
  expect_equal(
    as_co2e(10, gas = "HFC-134a", ar = "AR6", horizon = 100),
    10 * gwp("HFC-134a", ar = "AR6", horizon = 100)
  )
})

test_that("as_co2e() is vectorized over value and gas", {
  expect_equal(
    as_co2e(c(10, 5, 1), gas = c("HFC-134a", "CH4", "SF6"), ar = "AR6", horizon = 100),
    c(10, 5, 1) * gwp(c("HFC-134a", "CH4", "SF6"), ar = "AR6", horizon = 100)
  )
})

test_that("as_co2e() defaults to AR6, 100-year horizon", {
  expect_equal(
    as_co2e(10, gas = "HFC-134a"),
    as_co2e(10, gas = "HFC-134a", ar = "AR6", horizon = 100)
  )
})

test_that("as_co2e() propagates NA and warns for an unknown gas", {
  expect_warning(
    result <- as_co2e(10, gas = "totally-fake-gas"),
    "No GWP found for"
  )
  expect_true(is.na(result))
})
