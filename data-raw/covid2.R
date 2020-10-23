## code to prepare `covid2` dataset goes here
covid2 <- read.csv("data-raw/WHO-COVID-19-global-data.csv") %>% 
  mutate(date= as.Date(Date_reported, format = "%Y-%m-%d")) %>%
  filter(Country %in% c("Canada", "Australia")) %>%
  select(date, Country, cases = Cumulative_cases, deaths = Cumulative_deaths) %>%
  group_by(Country)
usethis::use_data(covid2, overwrite = TRUE)
