test_that("gwp_compare() returns one row per ar reporting the gas at the given horizon", {
  result <- gwp_compare("CFC-11")

  expect_named(result, c("ar", "gwp"))
  expect_equal(result$ar, c("AR4", "AR5", "AR6"))
  expect_equal(result$gwp, c(4750, 4660, 6230))
})

test_that("gwp_compare() defaults to a 100-year horizon", {
  expect_equal(gwp_compare("CFC-11"), gwp_compare("CFC-11", horizon = 100))
})

test_that("gwp_compare() returns zero rows for a gas/horizon combo with no data", {
  result <- gwp_compare("CFC-11", horizon = 50)
  expect_equal(nrow(result), 0)
})
