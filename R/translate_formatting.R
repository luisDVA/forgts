#' Translate Formatting Definitions
#'
#' Convert formatting information into arguments that can be used by `gt`.
#'
#' @param format_long Data frame produced by `get_formatting` containing raw formatting information.
#'
#' @return A data frame with formatting information compatible with gt.
#'
#' @export
#'
#' @importFrom dplyr case_when if_else mutate
#'
#' @examples
#' \dontrun{
#' format_long <- get_formatting("yourpath/yourspreadsheet.xlsx")
#' translate_defs(format_long)
#' }
translate_defs <- function(format_long) {
  # match styling arguments
  format_long_stl <- dplyr::mutate(format_long,
    styling_arg = dplyr::case_when(
      format == "bold" ~ "weight",
      format == "italic" ~ "style",
      format == "underlined" ~ "decorate",
      format == "strikethrough" ~ "decorate",
      grepl("color", format) ~ "color",
      grepl("top_style", format) ~ "top",
      grepl("right_style", format) ~ "right",
      grepl("bottom_style", format) ~ "bottom",
      grepl("left_style", format) ~ "left",
      grepl("clr", format) ~ "color",
      TRUE ~ format
    )
  )

  # type of formatting
  format_long_stlarg <- dplyr::mutate(format_long_stl,
    helper = dplyr::case_when(
      format == "bold" ~ "cell_text",
      format == "italic" ~ "cell_text",
      format == "underlined" ~ "cell_text",
      format == "strikethrough" ~ "cell_text",
      format == "text_clr" ~ "cell_text",
      format == "hl_color" ~ "cell_fill",
      grepl("border", format) ~ "cell_borders",
      TRUE ~ format
    )
  )

  # general translations
  format_long_stlarg <- dplyr::mutate(format_long_stlarg,
    arg_value = dplyr::case_when(
      format == "bold" & val == "TRUE" ~ "bold",
      format == "italic" & val == "TRUE" ~ "italic",
      format == "underlined" & val != "NA" ~ "underline",
      format == "strikethrough" & val != "FALSE" ~ "line-through",
      format == "hl_color" & val != "NA" ~ paste0("#", val),
      format == "text_clr" & val != "NA" ~ paste0("#", val),
      grepl("border_.+_clr", format) & val != "NA" ~ paste0("#", val),
      grepl("border_.+_style", format) & val != "NA" ~ val,
      TRUE ~ NA_character_
    )
  )

  # colorspace
  format_long_stlarg <- dplyr::mutate(format_long_stlarg,
    arg_value = dplyr::if_else(
      startsWith(arg_value, "#"),
      paste0(substr(arg_value, 1, 1), substr(arg_value, 4, nchar(arg_value))),
      arg_value
    )
  )

  # update border styles
  format_long_stlarg <- dplyr::mutate(format_long_stlarg,
    arg_value = dplyr::case_when(
      arg_value == "thin" ~ "1",
      arg_value == "thick" ~ "3",
      arg_value == "medium" ~ "2",
      TRUE ~ arg_value
    )
  )

  #  border_side and border_property
  format_long_stlarg <- dplyr::mutate(format_long_stlarg,
    border_side = dplyr::if_else(
      grepl(pattern = "border_.+_style", x = format) &
        helper == "cell_borders" &
        val != "NA",
      styling_arg,
      NA_character_
    )
  )

  format_long_stlarg <- dplyr::mutate(format_long_stlarg,
    border_property = dplyr::case_when(
      grepl(pattern = "border_.+_style", x = format) &
        helper == "cell_borders" ~ "sides",
      grepl(pattern = "border_.+_clr", x = format) &
        helper == "cell_borders" ~ "color",
      TRUE ~ NA_character_
    )
  )

  format_long_stlarg
}
