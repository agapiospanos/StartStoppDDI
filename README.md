START STOPP DDI - An R package that evaluates patient data for START
(Screening Tool to Alert doctors to Right Treatments), STOPP (Screening
Tool of Older People’s Potentially Inappropriate Prescriptions) criteria
and DDI (Drug to Drug Interaction)
================

## Description

This package is a combination of the packages DDI and STARTSTOPP that I
developed. It provides an easy way to evaluate both for DDI and
STARTSTOPP criteria at once.

We have included 68 DDI, 33 START and 76 STOPP criteria. For more
details visit <https://github.com/agapiospanos/StartStopp> and
<https://github.com/agapiospanos/DDI>

## Installation

The package is still under active development and has not been submitted
to the CRAN yet. You can install the STARTSTOPPDDI package from GitHub
repository as follows:

Installation using R package
**[devtools](https://cran.r-project.org/package=devtools)**:

``` r
install.packages("devtools")
devtools::install_github("agapiospanos/STARTSTOPPDDI")
```

## Input data format

I will soon provide an excel file as a template for the input data
format.

## Basic usage examples

Provided that you have the input data in the format specifed above you
can use the package by calling the eval\_crit function and using the
correct arguments. For example to evaluate the data for the all DDI and
START-STOPP criteria you can call the following function. This function
will display a popup window to choose a folder that the excel file will
be exported. Then another popup window will appear to choose the excel
file that contains the patient data.

``` r
eval_crit()
```

You can also exclude some criteria as
follows:

``` r
eval_crit(excludeDDI = c("DDI4"), excludeSTART = c("A2"), excludeSTOPP = c("B12"))
```

## Advanced usage examples

You can disable the excel file output and get a list with the results by
using the argument excel\_out = FALSE as shown below:

``` r
output_data <- eval_crit(excel_out = F)

# getting the full data
output_data$all_criteria

# getting only the sum of DDI, START and STOPP criteria met
output_data$sumdata
```

You can also get an excel file with the sums of DDI, START and STOPP
criteria met. You just have to set the show\_only\_sum argument to TRUE.
The column ddi.found indicates if at least one criterion is met (with 1)
or no DDI criterion is met (with 0). The column ddi.count indicates the
number of DDI criteria that each patient meets. The same goes for START
and STOPP criteria.

``` r
eval_crit(show_only_sum = T)
```

Finally, if you want to get multiple files for each DDI criterion and
not get the single excel file use the command below:

``` r
eval_crit(single_excel = F)
```

## All available options

  - selectedDDI (Character vector) (optional) (default: ‘all’) the
    selected criteria to export given in the form of c(“DDI1,”DDI6").
    Valid options ‘all’ and DDI1 to DDI68.
  - selectedSTOPP (Character vector) (optional) (default: ‘all’) the
    selected criteria to export given in the form of c(“B11”, "B12). If
    you want to include all criteria set to ‘all’.
  - selectedSTART (Character vector) (optional) (default: ‘all’) the
    selected criteria to export given in the form of c(“A1”, "A2). If
    you want to include all criteria set to ‘all’.
  - excel\_path (Character) (optional) (default: NULL) the path that the
    excel file can be read from. If NULL a file choose window will be
    displayed so that you can choose the excel file.
  - excludeDDI (Character) (optional) (default: NULL) a vector of
    criteria that you want to exclude. Example: c(“DDI1,”DDI6"). Valid
    options DDI1 to DDI68.
  - excludeSTOPP (Character) (optional) (default: NULL) a vector of
    STOPP criteria that you want to exclude. Example: c(‘B12’).
  - excludeSTART (Character) (optional) (default: NULL) a vector of
    START criteria that you want to exclude. Example: c(‘A1’).
  - excel\_out (Boolean) (optional) (default: TRUE) output excel file
    with the evaluated data.
  - single\_excel (Boolean) (optional) (default: TRUE) if true outputs
    only 1 excel file with multiple columns instead of multiple files
    (one for each criterion)
  - export\_data\_path (Character) (optional) (default: NULL (a popup
    message to choose dir will be displayed)) the path for excel file
    output.
  - suppressNA (Boolean) (optional) (default: TRUE) set this to FALSE if
    you want to know for which patients have NAs and for which variable.
    By default all NAs will be ignored so that the algorithm can
    distinguish between patients who meet the criterion and those who do
    not.
  - excel\_sheet (Character) (optional) (default: 1) the number of excel
    worksheet that the patient id and the ATC codes are stored.
  - excel\_col\_data (Character) (optional) (default:
    ’med\_gen\_\_decod’) the column name of the column that stores
    the ATC codes data in the provided excel file.
  - excel\_col\_pid (Character) (optional) (default: ‘usubjid’) the
    column name that specifies the patient id in the excel you provided
    for the data.
  - show\_only\_meet (Boolean) (optional) (default: FALSE) set to TRUE
    if you want to have exported in the excel only the patients that
    meet the conditions for this criterion
  - show\_only\_sum (Boolean) (optional) (default: FALSE) set to TRUE if
    you want to show only the number of number of criteria that are met
    for each patient and a boolean value of 0 if no criterion is met and
    1 if at least one is met.
