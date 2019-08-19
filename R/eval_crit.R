#' Evaluates the imported patients' data for the selected START STOPP and DDI criteria at once.
#'
#' @author
#' Agapios Panos <panosagapios@gmail.com>
#'
#' @param selectedDDI (Character vector) (optional) (default: 'all') the selected criteria to export given in the form of c("DDI1, "DDI6"). Valid options 'all' and DDI1 to DDI68.
#' @param selectedSTOPP (Character vector) (optional) (default: 'all') the selected criteria to export given in the form of c("B11", "B12). If you want to include all criteria set to 'all'.
#' @param selectedSTART (Character vector) (optional) (default: 'all') the selected criteria to export given in the form of c("A1", "A2). If you want to include all criteria set to 'all'.
#' @param excel_path (Character) (optional) (default: NULL) the path that the excel file can be read from. If NULL a file choose window will be displayed so that you can choose the excel file.
#' @param excludeDDI (Character) (optional) (default: NULL) a vector of criteria that you want to exclude. Example: c("DDI1, "DDI6"). Valid options DDI1 to DDI68.
#' @param excludeSTOPP (Character) (optional) (default: NULL) a vector of STOPP criteria that you want to exclude. Example: c('B12').
#' @param excludeSTART (Character) (optional) (default: NULL) a vector of START criteria that you want to exclude. Example: c('A1').
#' @param excel_out (Boolean) (optional) (default: TRUE) output excel file with the evaluated data.
#' @param single_excel (Boolean) (optional) (default: TRUE) if true outputs only 1 excel file with multiple columns instead of multiple files (one for each criterion)
#' @param export_data_path (Character) (optional) (default: NULL (a popup message to choose dir will be displayed)) the path for excel file output.
#' @param suppressNA (Boolean) (optional) (default: TRUE) set this to FALSE if you want to know for which patients have NAs and for which variable. By default all NAs will be ignored so that the algorithm can distinguish between patients who meet the criterion and those who do not.
#' @param excel_sheet (Character) (optional) (default: 1) the number of excel worksheet that the patient id and the ATC codes are stored.
#' @param excel_col_data (Character) (optional) (default: 'med_gen__decod') the column name of the column that stores the ATC codes data in the provided excel file.
#' @param excel_col_pid (Character) (optional) (default: 'usubjid') the column name that specifies the patient id in the excel you provided for the data.
#' @param show_only_meet (Boolean) (optional) (default: FALSE) set to TRUE if you want to have exported in the excel only the patients that meet the conditions for this criterion
#' @param show_only_sum (Boolean) (optional) (default: FALSE) set to TRUE if you want to show only the number of number of criteria that are met for each patient and a boolean value of 0 if no criterion is met and 1 if at least one is met.
#'
#' @importFrom writexl write_xlsx
#' @importFrom stats setNames
#' @importFrom DDI eval_crit
#' @importFrom StartStopp STARTSTOPPbycategory
#'
#' @export


eval_crit <- function(selectedDDI = 'all', selectedSTOPP = 'all', selectedSTART = 'all', excel_path = NULL, excludeDDI = NULL, excludeSTOPP = NULL, excludeSTART = NULL, excel_out = TRUE, single_excel = TRUE, export_data_path = NULL, suppressNA = TRUE, excel_sheet = 1, excel_col_data = 'med_gen__decod', excel_col_pid = 'usubjid', show_only_meet = FALSE, show_only_sum = FALSE) {
  # checking the excel_path. If NULL a file choose message will be displayed.
  excel_path <- chk_file(excel_path)
  cat('You selected the following excel file: ', excel_path)

  if (excel_out) {
    # choosing an export path for the excel file that contains the evaluated patients' data.
    export_data_path <- choose_export_path(export_data_path)
  }

  ddi <- DDI::eval_crit(selected = selectedDDI, excel_path = excel_path, exclude = excludeDDI, excel_out = F, single_excel = single_excel, export_data_path = export_data_path, suppressNA = suppressNA, excel_sheet = excel_sheet, excel_col_data = excel_col_data, excel_col_pid = excel_col_pid, show_only_meet = show_only_meet, show_only_sum = show_only_sum)

  startstopp <- StartStopp::STARTSTOPPbycategory(excel_path, excludeSTART, excludeSTOPP, excel_out = F, single_excel, export_data_path, suppressNA)

  output <- list()

  output$sumdata <- merge(ddi$sumdata, startstopp$sumdata)
  output$criteria <- merge(merge(ddi$all_criteria, startstopp$start), startstopp$stopp)

  if (excel_out) {
    if (show_only_sum) {
      write_xlsx(output$sumdata, path = paste0( export_data_path, '/STARTSTOPPDDI_sum_critetia_by_category.xlsx'), col_names = TRUE)
    } else {
      write_xlsx(output$sumdata, path = paste0( export_data_path, '/STARTSTOPPDDI_sum_critetia_by_category.xlsx'), col_names = TRUE)
      write_xlsx(output$criteria, path = paste0( export_data_path, '/STARTSTOPPDDI_all_critetia_by_category.xlsx'), col_names = TRUE)
    }
  }

  # return evaluated data
  invisible (list(ddi = ddi$allcriteria, start = startstopp$start, stopp = startstopp$stopp, sumdata = output$sumdata)) # instead of return as we do not want to be printed

}
