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
#' @importFrom rlang .data
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
                                     .data$format == "bold" ~ "weight",
                                     .data$format == "italic" ~ "style",
                                     .data$format == "underlined" ~ "decorate",
                                     .data$format == "strikethrough" ~ "decorate",
                                     grepl("color", .data$format) ~ "color",
                                     grepl("top_style", .data$format) ~ "top",
                                     grepl("right_style", .data$format) ~ "right",
                                     grepl("bottom_style", .data$format) ~ "bottom",
                                     grepl("left_style", .data$format) ~ "left",
                                     grepl("clr", .data$format) ~ "color",
                                     TRUE ~ .data$format
                                   )
  )

  # type of formatting
  format_long_stlarg <- dplyr::mutate(format_long_stl,
                                      helper = dplyr::case_when(
                                        .data$format == "bold" ~ "cell_text",
                                        .data$format == "italic" ~ "cell_text",
                                        .data$format == "underlined" ~ "cell_text",
                                        .data$format == "strikethrough" ~ "cell_text",
                                        .data$format == "text_clr" ~ "cell_text",
                                        .data$format == "hl_color" ~ "cell_fill",
                                        grepl("border", .data$format) ~ "cell_borders",
                                        TRUE ~ .data$format
                                      )
  )

  # general translations
  format_long_stlarg <- dplyr::mutate(format_long_stlarg,
                                      arg_value = dplyr::case_when(
                                        .data$format == "bold" & .data$val == "TRUE" ~ "bold",
                                        .data$format == "italic" & .data$val == "TRUE" ~ "italic",
                                        .data$format == "underlined" & .data$val != "NA" ~ "underline",
                                        .data$format == "strikethrough" & .data$val != "FALSE" ~ "line-through",
                                        .data$format == "hl_color" & .data$val != "NA" ~ paste0("#", .data$val),
                                        .data$format == "text_clr" & .data$val != "NA" ~ paste0("#", .data$val),
                                        grepl("border_.+_clr", .data$format) & .data$val != "NA" ~ paste0("#", .data$val),
                                        grepl("border_.+_style", .data$format) & .data$val != "NA" ~ .data$val,
                                        TRUE ~ NA_character_
                                      )
  )

  # colorspace
  format_long_stlarg <- dplyr::mutate(format_long_stlarg,
                                      arg_value = dplyr::if_else(
                                        startsWith(.data$arg_value, "#"),
                                        paste0(substr(.data$arg_value, 1, 1), substr(.data$arg_value, 4, nchar(.data$arg_value))),
                                        .data$arg_value
                                      )
  )

  # update border styles
  format_long_stlarg <- dplyr::mutate(format_long_stlarg,
                                      arg_value = dplyr::case_when(
                                        .data$arg_value == "thin" ~ "1",
                                        .data$arg_value == "thick" ~ "3",
                                        .data$arg_value == "medium" ~ "2",
                                        TRUE ~ .data$arg_value
                                      )
  )

  #  border_side and border_property
  format_long_stlarg <- dplyr::mutate(format_long_stlarg,
                                      border_side = dplyr::if_else(
                                        grepl(pattern = "border_.+_style", x = .data$format) &
                                          .data$helper == "cell_borders" &
                                          .data$val != "NA",
                                        .data$styling_arg,
                                        NA_character_
                                      )
  )

  format_long_stlarg <- dplyr::mutate(format_long_stlarg,
                                      border_property = dplyr::case_when(
                                        grepl(pattern = "border_.+_style", x = .data$format) &
                                          .data$helper == "cell_borders" ~ "sides",
                                        grepl(pattern = "border_.+_clr", x = .data$format) &
                                          .data$helper == "cell_borders" ~ "color",
                                        TRUE ~ NA_character_
                                      )
  )

  format_long_stlarg
}

# Declare global variables
utils::globalVariables(c("format", "val", "styling_arg", "helper"))
