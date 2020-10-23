#' Title
#'library(magrittr)
#' @param Country 
#'
#' @return
#' @export
#'
#' @examples

ui <- function(Country){
  # if (is.na(Country))
  #   stop("Country should not NULL")
  input$date <- covid2 %>% fiilter(date >= "2020-10-01",
                                   date <= "2020-10-07")
}
