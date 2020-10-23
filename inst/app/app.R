library(shiny)
library(tidyverse)
library(readr)
library(plotly)
library(hrbrthemes)
library(kableExtra)
library(lubridate)
library(dplyr)
library(xts)
library(shinydashboard)
library(dygraphs)

covid <- read.csv("data/WHO-COVID-19-global-data.csv") %>%
  filter(Country %in%c("Canada", "Australia"))
covid$Date_reported <- as.Date(covid$Date_reported, format = "%Y-%m-%d")
covid1 <- covid %>% mutate(date= as.Date(Date_reported, format = "%Y-%m-%d")) %>%
  filter(Country %in% c("Canada", "Australia")) %>%
  filter(date > "2020-03-01" & date < "2020-05-01") %>%
  select(date, Country, cases = New_cases) %>%
  group_by(Country)
covid2 <- covid %>% mutate(date= as.Date(Date_reported, format = "%Y-%m-%d")) %>%
  filter(Country %in% c("Canada", "Australia")) %>%
  select(date, Country, cases = Cumulative_cases, deaths = Cumulative_deaths) %>%
  group_by(Country)

ui <- fluidPage( dashboardHeader(title = "Visualising and analysing the COVID19 cases in Australia and Canada"),
                 h4("About"),
                 p("Creator: Yuqi Wang ywan0454@student.monash.edu"),
                 p("Purpose: This web app intend to visualizing and analyzing the number of cases and deaths of COVID19 in Australia and Canada based on the data from WHO. Australia and Canada land areas and polulation status are similar and their control of COVID19 were better than other countries at the beginning. However the difference of confirmed cases become bigger as the development of this epidemic. This app will combine table and plots to display not only the trend but also everyday statistics of COVID19 cases in both countries."),
                 br(),
                 sidebarLayout(
                   sidebarPanel(
                     h3("Total confirmed cases and deaths"),
                     dashboardBody(
                       fluidRow(
                         dateRangeInput("date", "Date Range:",
                                        start = "2020-10-01",
                                        end = "2020-10-07"),
                         
                         dataTableOutput("table"),
                         p("Disaplaying the COVID19 cases and desths of Australia and Canada from 2020-01-03 to 2020-10-07 by selecting the date range on the top of the table. It is clear to see the cases in Canada was more than 150000 recently which is much more than Australia with not more than 30000 cases in October 2020."),
                         p("Selecting which country you want to look at on the top of plot on the right. Visualizing the total cases and deaths by slide the cursor on the curve on dygragh, it will shows the number of cases and deaths curve from 2020-01-03 to 2020-10-07 in the certain country.")
                       ))),
                   mainPanel(h3("Compare new cases in Australia and Canada"),
                             plotlyOutput("gragh1"),
                             verbatimTextOutput("plotlyClick"),
                             p("Australia and Canada land areas are almost large and their control of COVID19 were better than other countries at the beginning.At the beginning of March, the cases of covid in both Australia and Canada are almost zero. There is an significant increase of COVID19 cases in Canada from the end of March to May. Although after the middle of March there is an significant increase in Australia almost 600 cases/ day, this situation have controlled after one month. "),
                             p("The significant different development of the epidemic situation in the two countries is mainly due to the policies adopted. As @Costantino2020effectiveness wrote, on February 1, the Australian government implemented strict entry restrictions for person who came from the outbreak occurred countries. On March 19, Australia officially announced the closure of the entire territory. Non-Australian citizens / residents are prohibited from entering Australia. These measures strongly suppressed the continuous input of external infection cases earlier. Canada also issued a travel ban on March 18. The difference is that Canada ’s border policy is one-way to prohibit entry of people from high-risk countries, but Australia ’s border blockade is two-way. As @Chang2020modelling analysed that Australia not only does it prohibit all non-Australian citizens and residents from entering the country, but also restricts the exit, the two-way restriction measures minimize the cross-border spread of the virus."),    
                             
                             h3("Compare total cases in Australia and Canada"),
                             selectInput("Country", "What country do you want to look at?",
                                         choices = c("Canada", "Australia"),
                                         selected = "Australia"),
                             dygraphOutput("gragh2"))           )
                 
                 
                 
)

  
  
              
  

server <- function(input, output, session) {
  output$gragh1 <- renderPlotly({
    g <- ggplot(data = covid1, aes(x = date, y = cases, color = Country)) +
      geom_line() +
      ggtitle("Covid19 new cases in Australia and Canada, 01 March 2020 - 01 May 2020") 
    ggplotly(g)
  })
  output$plotlyClick <- renderPrint(event_data("plotly_hover")) 
  output$gragh2 <- renderDygraph({
    covid3 <- filter(covid2, Country==input$Country)
    g2=xts(x= covid3[,-1], order.by=covid3$date)
    dygraph(g2)
  })
  table1 <- reactive({
    covid4 <- covid2[which(covid2$date >= input$date[1] & covid2$date <= input$date[2]),]
    
    
  })
  
  output$table <- renderDataTable(table1(),
                                  options = list(pageLength = 15))
  }
  
  


shinyApp(ui, server)
