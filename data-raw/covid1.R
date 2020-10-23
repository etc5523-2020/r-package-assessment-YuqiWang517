## code to prepare `covid1` dataset goes here
covid1 <- read.csv("data-raw/WHO-COVID-19-global-data.csv") %>% 
  mutate(date= as.Date(Date_reported, format = "%Y-%m-%d")) %>%
  filter(Country %in% c("Canada", "Australia")) %>%
  filter(date >= "2020-03-01" & date <= "2020-05-01") %>%
  select(date, Country, cases = New_cases) %>%
  group_by(Country)

usethis::use_data(covid1, overwrite = TRUE)
