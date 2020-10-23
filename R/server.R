#' Title
#'
#' @param 
#'
#' @return
#' @export
#'
#' @examples
server <- function(date, cases, Country){
  output$gragh1 <- renderPlotly({
    g <- ggplot(data = covid1, aes(x = date, y = cases, color = Country)) +
      geom_line() +
      ggtitle("Covid19 new cases in Australia and Canada, 01 March 2020 - 01 May 2020") 
    ggplotly(g)
  })
  output$plotlyClick <- renderPrint(event_data("plotly_hover")) 
  # covid1 %>% ggplot(aes(x = date, y = cases, color = Country)) +
  #     geom_line() +
  #     ggtitle("Covid19 new cases in Australia and Canada, 01 March 2020 - 01 May 2020")
    
}