
#' @export
launch_app <- function() {
  
  appDir <- system.file("app", package = "covidpkg")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `covidpkg`.", call. = FALSE)
  }
  shiny::runApp(appDir, display.mode = "normal")

}



