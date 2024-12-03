test_that("styling is applied properly", {
# test data frame
test_data <- data.frame(
  Column1 = c("A", "B", "C"),
  Column2 = c(1, 2, 3),
  Column3 = c("X", "Y", "Z")
)

gt_table <- gt(test_data) # to gt

# formatting as produced in this pkg
format_ready <- tibble::tribble(
  ~helper,       ~styling_arg, ~arg_value, ~target_var, ~rowid, ~border_property, ~border_side,
  "cell_text",   "weight",     "bold",     "Column1",   "1",    NA,               NA,
  "cell_text",   "style",      "italic",   "Column2",   "2",    NA,               NA,
  "cell_text",   "decorate",   "underline","Column3",   "3",    NA,               NA,
  "cell_text",   "color",      "#FF0000",  "Column1",   "2",    NA,               NA,
  "cell_fill",   NA,           "#FFFF00",  "Column2",   "3",    NA,               NA,
  "cell_borders", NA,          "thin",     "Column1",   "1",    "sides",          "all"
)

# apply the styling
styled_table <- apply_styling(gt_table, format_ready)

# is the output a gt?
expect_s3_class(styled_table, "gt_tbl")

# helper for checking styles
check_style <- function(styles, column, row, style_type, property, value) {
  style_rows <- styles[styles$colname == column & styles$rownum == row, ]
  any(sapply(style_rows$styles, function(style_list) {
    if (style_type %in% names(style_list)) {
      return(identical(style_list[[style_type]][[property]], value))
    }
    FALSE
  }))
}

# text styles
expect_true(check_style(styled_table$`_styles`, "Column1", 1, "cell_text", "weight", "bold"))
expect_true(check_style(styled_table$`_styles`, "Column2", 2, "cell_text", "style", "italic"))
expect_true(check_style(styled_table$`_styles`, "Column3", 3, "cell_text", "decorate", "underline"))
expect_true(check_style(styled_table$`_styles`, "Column1", 2, "cell_text", "color", "#FF0000"))

# check the fill color
expect_true(check_style(styled_table$`_styles`, "Column2", 3, "cell_fill", "color", "#FFFF00"))

# borders
border_sides <- c("top", "right", "bottom", "left")
for (side in border_sides) {
  border_style_name <- paste0("cell_border_", side)
  expect_true(check_style(styled_table$`_styles`, "Column1", 1, border_style_name, "side", side))
  expect_true(check_style(styled_table$`_styles`, "Column1", 1, border_style_name, "width", "1px"))
  expect_true(check_style(styled_table$`_styles`, "Column1", 1, border_style_name, "style", "solid"))
  expect_true(check_style(styled_table$`_styles`, "Column1", 1, border_style_name, "color", "#000000"))
}
})
