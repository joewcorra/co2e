test_that("gwp() looks up a single gas correctly", {
  expect_equal(gwp("CH4", ar = "AR6", horizon = 100), 27.9)
})

test_that("gwp() is vectorized over gas, with ar/horizon recycled", {
  expect_equal(
    gwp(c("CO2", "CH4", "HFC-32"), ar = "AR6", horizon = 100),
    c(1, 27.9, 771)
  )
})

test_that("gwp() defaults to AR6, 100-year horizon", {
  expect_equal(gwp("CH4"), gwp("CH4", ar = "AR6", horizon = 100))
})

test_that("gwp() returns NA with a warning for an unknown gas", {
  expect_warning(
    result <- gwp("totally-fake-gas", ar = "AR6", horizon = 100),
    "No GWP found for: totally-fake-gas"
  )
  expect_true(is.na(result))
})

test_that("gwp() returns NA with a warning for a valid gas at an unlisted horizon", {
  # 50 is not one of the package's supported horizons (20 / 100 / 500)
  expect_warning(
    result <- gwp("CO2", ar = "AR6", horizon = 50),
    "No GWP found for"
  )
  expect_true(is.na(result))
})
