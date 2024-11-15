test_that("get_formatting extracts formatting information in a long, key-value format", {
  test_spreadsheet <- system.file("extdata", "rodentsheet.xlsx", package = "forgts")

  formatting <- get_formatting(test_spreadsheet)

  expect_true("format" %in% names(formatting))
  expect_true("val" %in% names(formatting))
})
