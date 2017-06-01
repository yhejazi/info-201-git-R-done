library(httr)
library(purrr)
library(jsonlite)
library(dplyr)
library(plotly)
library(stringr)

# MakeMap function returns a map of the average rating of specified cuisine for the most populated city in each state 

MakeMap <- function(food.type.input) {
  # Read in rating information for the input food type
  all.ratings <- read.csv(paste0("./data/", food.type.input, "-map.csv"), stringsAsFactors = FALSE)
  
  # Check food type for map title
  title.food <- food.type.input
  if (food.type.input == 'indpak') {
    title.food <- 'Indian'
  } else if (food.type.input == 'tradamerican') {
    title.food <- 'American (Traditional)'
  }
  
  # Map georgraphy
  geog <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showland = TRUE,
    landcolor = toRGB("gray95"),
    subunitcolor = toRGB("gray85"),
    countrycolor = toRGB("gray85"),
    countrywidth = 0.5,
    subunitwidth = 0.5
  )
  
  # Creates map
  map <- plot_geo(all.ratings, locationmode= 'USA-states',lat = ~lat, lon = ~long)  %>% 
    add_markers(
      z = ~mean.rating, locations = ~states, colors = 'YlOrRd',
      text = ~paste('Most populated city:', most.pop.city, 
                    paste('Rating:', round(mean.rating, digits = 2)), 
                    sep = '<br />'),
      color = ~mean.rating,
      hoverinfo = 'text'
    ) %>%
    layout(
      title = paste0("Average Rating of ", str_to_title(title.food), " Restaurants in the U.S."), 
      geo = geog
    )
  
  return (map)
}