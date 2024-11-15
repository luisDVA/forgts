test_that("formatting is translated from spreadsheet to gt", {
  sample_format_long <- data.frame(
    format = c("bold", "italic", "hl_color"),
    val = c("TRUE", "TRUE", "#FF0000")
  )

  translated <- translate_defs(sample_format_long)

  expect_true("styling_arg" %in% names(translated))
  expect_true("helper" %in% names(translated))
  expect_true("arg_value" %in% names(translated))

  expect_equal(translated$arg_value[translated$format == "bold"], "bold")
  expect_equal(translated$arg_value[translated$format == "italic"], "italic")
  expect_equal(translated$arg_value[translated$format == "hl_color"], "#F0000")
})
