library(httr)
library(purrr)
library(jsonlite)
library(dplyr)
library(plotly)
library(stringr)

MakeMap <- function(food.type.input) {
  pop.city.US <- read.csv(file = 'most-pop-cities.csv', stringsAsFactors = FALSE)
  most.pop.city <- pop.city.US$most.pop.city
  
  AvgRating <- function(food.type, city) {
    res <- POST("https://api.yelp.com/oauth2/token",
                body = list(grant_type = "client_credentials",
                            client_id = "iXvoLjOm6wir50Rq0XrwZg",
                            client_secret =
                              "2jifA0p0BWQROgO6Kmarl9bBc6WFwLH3r8SP9fzFmbrHkq98suQRgAP3OoBduC4u"))

    token <- httr::content(res)$access_token

    yelp <- "https://api.yelp.com"
    location <- city
    limit <- 30
    offset <- 0
    categories <- food.type

    (url <- modify_url(yelp, path = c("v3", "businesses", "search"),
             query = list(location = location, categories = categories, limit = limit, offset = 0)))

    res <- GET(url, add_headers('Authorization' = paste("bearer", token)))

    response.content <- httr::content(res, "text", encoding = "UTF-8")
    body.data <- fromJSON(response.content)
    test <- is.data.frame(body.data$businesses)

    results <- body.data$businesses
    
    most.pop.city <- city
    if (test == FALSE){
      mean.rating <- -1
    } else {
      mean.rating <- mean(results$rating) 
    }
    output <- data.frame(food.type, most.pop.city, mean.rating, stringsAsFactors = FALSE)
    pop.city.US <- merge(pop.city.US, output, all = TRUE)
    return (pop.city.US)
  }
  
  list.df.ratings <- lapply(most.pop.city, AvgRating, food.type=food.type.input)
  
  all.ratings <- reduce(list.df.ratings, full_join, by = c('most.pop.city','states', 'lat', 'long', 'mean.rating')) %>% 
    filter(!is.na(mean.rating))
  
  title.food <- food.type.input
  if (food.type.input == 'indpak') {
    title.food <- 'Indian'
  } else if (food.type.input == 'tradamerican') {
    title.food <- 'American (Traditional)'
  }
  
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
  
  map <- plot_geo(all.ratings, locationmode= 'USA-states',lat = ~lat, lon = ~long)  %>% 
    add_markers(
      z = ~mean.rating, locations = ~states,
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