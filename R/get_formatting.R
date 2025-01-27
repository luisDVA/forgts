#' Get Spreadsheet Formatting
#'
#' Extracts formatting information from a spreadsheet.
#'
#' @param file A character string specifying the path to the spreadsheet.
#' @param sheet A character string with the name of a sheet within a workbook,
#'   or an integer with the position of the sheet. Defaults to the first sheet
#'   if left unspecified.
#' @return A data frame or list with parsed formatting information.
#'
#' @export
#'
get_formatting  <- function(xlfilepath, sheet = NULL) {
  if (is.null(sheet)) {
    sheet <- 1L
  }
  spsheet <- readxl::read_excel(xlfilepath, sheet = sheet)

  if (any(grepl("^\\.\\.\\.", names(spsheet)))) {
    stop("Check the spreadsheet for empty values in the header row")
  }

  m_formatting <- tidyxl::xlsx_cells(xlfilepath, sheets = sheet)

  m_formatting <-
    dplyr::ungroup(tidyr::complete(dplyr::group_by(m_formatting, col),
      row = tidyr::full_seq(row, 1)
    ))

  if (nrow(spsheet) != max(m_formatting$row) - 1) {
    stop("Check spreadsheet for blank cells in seemingly empty rows")
  }

  if (length(unique(stats::na.omit(m_formatting$sheet))) != 1) {
    stop("Data in spreadsheet does not appear to be rectangular (this includes multisheet files)")
  }

  format_defs <- tidyxl::xlsx_formats(xlfilepath)

  bold <- format_defs$local$font$bold
  italic <- format_defs$local$font$italic
  underlined <- format_defs$local$font$underline
  hl_color <- format_defs$local$fill$patternFill$fgColor$rgb
  strikethrough <- format_defs$local$font$strike
  text_clr <- format_defs$local$font$color$rgb
  border_top_style <- format_defs$local$border$top$style
  border_top_clr <- format_defs$local$border$top$color$rgb
  border_right_style <- format_defs$local$border$right$style
  border_right_clr <- format_defs$local$border$right$color$rgb
  border_bottom_style <- format_defs$local$border$bottom$style
  border_bottom_clr <- format_defs$local$border$bottom$color$rgb
  border_left_style <- format_defs$local$border$left$style
  border_left_clr <- format_defs$local$border$left$color$rgb

  format_opts <- tibble::lst(
    bold, hl_color, italic,
    strikethrough, text_clr, underlined, border_top_clr,
    border_top_style, border_right_clr, border_right_style,
    border_bottom_clr, border_bottom_style, border_left_clr,
    border_left_style
  )
  formatting_indicators <- dplyr::bind_cols(lapply(
    format_opts,
    function(x) x[m_formatting$local_format_id]
  ))

  format_joined <- dplyr::bind_cols(m_formatting, formatting_indicators)


  cols_spsheet <- match(
    names(spsheet),
    format_joined$character
  )


  # format for target variable
  target_vars <- vector("list", ncol(spsheet))
  for (i in seq_along(names(spsheet))) {
    target_vars[[i]] <- target_var_fmt(format_joined, spsheet, names(spsheet)[i])
  }

  purrr::list_rbind(target_vars)
}


#' Colwise formatting
#'
#' @param format_joined A data frame produced internally by `get_formatting`
#' @param spsheet Data frame version of spraedsheet.
#' @param col_name Variable to operate on.
#'
#' @return Modified data frame in long format.
#'
target_var_fmt <- function(format_joined, spsheet, col_name) {
  col_ind <- which(names(spsheet) == col_name)
  orig_format <- dplyr::filter(format_joined, row >= 2 & col == col_ind)
  orig_format <- dplyr::select(orig_format, bold:border_left_style)

  orig_format <-
    mutate(orig_format,
           target_var := names(spsheet[col_ind]), .before = 1)
  orig_format <- tibble::rowid_to_column(orig_format)
  orig_format <- mutate(orig_format, across(everything(), as.character))

  tidyr::pivot_longer(orig_format, -c(1, 2),
                      names_to = "format",values_to = "val")
}
