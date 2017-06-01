library(httr)
library(purrr)
library(jsonlite)
library(plotly)
library(ggplot2)

#Create a stacked bar chart that has the number of restaurants of a specific type and 
#uses price range as a stacked variable depending on given city
MakeStackedBar <- function(location) {
  cityname <- str_replace_all(location, "[^[:alnum:]]", "") #take out punctuation to get cityname for file
  city_data <- read.csv(file = paste0("./data/", cityname, "PriceData.csv"))
  
  p <- plot_ly(city_data, x = ~type, y = ~one, type = 'bar', name = "Inexpensive") %>%
    add_trace(y = ~city_data$two, name = 'Moderate') %>%
    add_trace(y = ~city_data$three, name = 'Pricey') %>%
    add_trace(y = ~city_data$four, name = 'Ultra High-End') %>%
    layout(title = paste("# Restaurants in", location, "by Type w/Price Level"), xaxis = list(title = 'Type of Food'), yaxis = list(title = 'Count'),
           barmode = 'stack', margin = list(b = 100))
  return (p)
}