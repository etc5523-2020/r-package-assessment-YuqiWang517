#'Shiny for comparing COVID19 cases in Australia and Canada
#'
#'This is visualazing and analyzing cases and deaths from 03 Jan 2020 to 07 Oct 2020 in Australia and Canada 
#'
#'
#' @export
"launch_app"

launch_app <- function() {
  
  appDir <- system.file("app", package = "covidpkg")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `covidpkg`.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")

}



