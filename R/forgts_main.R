#' Creat gt from  spreadsheet
#'
#' Wrapper. Reads a spreadsheet file including most formatting information and creates a
#' formatted gt table with the same data and formatting.
#'
#' @param file Path to a spreadsheet.
#' @param sheet A character string with the name of a sheet within a workbook,
#'   or an integer with the position of the sheet. Defaults to the first sheet
#'   if left unspecified.
#' @return A great table!
#'
#'
#' @export
#'
#' @examples
#' \dontrun{
#' forgts("yourpath/yourspreadsheet.xlsx")
#' }
forgts <- function(file,sheet=NULL) {
  if (is.null(sheet)) {
    sheet <- 1L
  }
  sprdsht_data <- readxl::read_excel(file,sheet=sheet)
  format_long <- get_formatting(file)
  formatRdy <- translate_defs(format_long)
  gt_table <- gt::gt(sprdsht_data)
  apply_styling(gt_table, formatRdy)
}
