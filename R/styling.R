#' Apply Spreadsheet Formatting to gt Table
#'
#' Applies formatting to a gt table based on information extracted from the spreadsheet file.
#'
#' @param gt_table A gt object.
#' @param formatRdy A data frame with formatting definitions.
#'
#' @return A great table!
#'
#' @export
#'
#' @examples
#' \dontrun{
#' sprdsht_data <- read_excel("yourpath/yourspreadsheet.xlsx")
#' gt_table <- gt::gt(sprdsht_data)
#' format_long <- get_formatting("yourpath/yourspreadsheet.xlsx")
#' format_ready <- translate_defs(format_long)
#' apply_styling(gt_table, format_ready)
#' }
#'
#' @importFrom gt gt
apply_styling <- function(gt_object, formatRdy) {
  # list for each cell's borders
  border_styles <- list()

  for (i in 1:nrow(formatRdy)) {
    row <- formatRdy[i, ]

    # Text styling (bold, italic, underline, strikethrough)
    if (row$helper == "cell_text" && !is.na(row$arg_value)) {
      style_fn <- switch(row$styling_arg,
                         "weight" = function(x) gt::cell_text(weight = x),
                         "style" = function(x) gt::cell_text(style = x),
                         "decorate" = function(x) gt::cell_text(decorate = x),
                         "color" = function(x) gt::cell_text(color = x))

      gt_object <-
        gt::tab_style(gt_object,
          style = style_fn(row$arg_value),
          locations = gt::cells_body(
            columns = c(row$target_var),
            rows = as.numeric(row$rowid)
          )
        )
    }

    # Fill color
    if (row$helper == "cell_fill" && !is.na(row$arg_value)) {
      gt_object <-
        gt::tab_style(gt_object,
          style = gt::cell_fill(color = row$arg_value),
          locations = gt::cells_body(
            columns = c(row$target_var),
            rows = as.numeric(row$rowid)
          )
        )
    }

    # iterate border styling
    if (row$helper == "cell_borders" && !is.na(row$arg_value)) {
      cell_key <- paste(row$target_var, row$rowid, sep = "_")
      if (is.null(border_styles[[cell_key]])) {
        border_styles[[cell_key]] <- list(
          target_var = row$target_var,
          rowid = as.numeric(row$rowid),
          top = list(), right = list(), bottom = list(), left = list()
        )
      }

      if (row$border_property == "color") {
        for (side in c("top", "right", "bottom", "left")) {
          border_styles[[cell_key]][[side]]$color <- row$arg_value
        }
      } else if (row$border_property == "sides") {
        side <- switch(row$border_side,
                       "left" = "left",
                       "right" = "right",
                       "top" = "top",
                       "bottom" = "bottom",
                       "all")
        weight <- switch(row$arg_value,
                         "thin" = gt::px(1),
                         "medium" = gt::px(2),
                         "thick" = gt::px(3),
                         gt::px(1))
        if (side == "all") {
          for (s in c("top", "right", "bottom", "left")) {
            border_styles[[cell_key]][[s]]$weight <- weight
          }
        } else {
          border_styles[[cell_key]][[side]]$weight <- weight
        }
      }
    }
  }

  # apply border styles
  for (cell_key in names(border_styles)) {
    cell_style <- border_styles[[cell_key]]
    for (side in c("top", "right", "bottom", "left")) {
      if (length(cell_style[[side]]) > 0) {
        gt_object <-
          gt::tab_style(gt_object,
            style = do.call(gt::cell_borders, c(list(sides = side), cell_style[[side]])),
            locations = gt::cells_body(
              columns = c(cell_style$target_var),
              rows = cell_style$rowid
            )
          )
      }
    }
  }

  return(gt_object)
}
