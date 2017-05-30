library(httr)
library(purrr)
library(jsonlite)
library(dplyr)
library(plotly)

# largest cities by population per state
most.pop.city <- c('Birmingham, AL', 'Phoenix, AZ', 'Little Rock, AR', 'Los Angeles, CA', 'Denver, CO',
                   'Bridgeport, CT', 'Wilmington, DE', 'Jacksonville, FL', 'Atlanta, GA', 'Boise, ID', 
                   'Chicago, IL', 'Indianapolis, IN', 'Des Moines, IA', 'Wichita, KS', 'Louisville, KY',
                   'New Orleans, LA', 'Portland, ME', 'Baltimore, MD', 'Boston, MA', 'Detroit, MI', 
                   'Minneapolis, MN', 'Jackson, MS', 'Kansas City, MO', 'Billings, MT', 'Omaha, NE',
                   'Las Vegas, NV', 'Manchester, NH', 'Newark, NJ', 'Albuquerque, NM', 'New York City, NY',
                   'Charlotte, NC', 'Fargo, ND', 'Columbus, OH', 'Oklahoma City, OK', 'Portland, OR',
                   'Philadelphia, PA', 'Providence, RI', 'Columbia, SC', 'Sioux Falls, SD', 'Memphis, TN',
                   'Houston, TX', 'Salt Lake City, UT', 'Burlington, VT', 'Virginia Beach, VA', 'Seattle, WA',
                   'Charleston, WV', 'Milwaukee, WI', 'Cheyenne, WY')

states <- c('AL', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'ID',
            'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD', 'MA', 'MI',
            'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY',
            'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 'SD', 'TN',
            'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY')

lat <- c(33.5207, 33.4484, 34.7465, 34.0522, 39.7392, 
         41.1865, 39.7391, 30.3322, 33.7490, 43.6187,
         41.8781, 39.7684, 41.6005, 37.6872, 38.2527,
         29.9511, 43.6615, 39.2904, 42.3601, 42.3314,
         44.9778, 32.2988, 39.0997, 45.7833, 41.2524, 
         36.1699, 42.9956, 40.7357, 35.0853, 40.7128,
         35.2271, 46.8772, 39.9612, 35.4676, 45.5231,
         39.9526, 41.8240, 34.0007, 42.5446, 35.1495,
         29.7604, 40.7608, 44.4759, 36.8529, 47.6062, 
         38.3498, 43.0389, 41.1400)

long <- c(-86.8025, -112.0740, -92.2896, -118.2437, -104.9903, 
          -73.1952, -75.5398, -81.6557, -84.3880, -116.2146, 
          -87.6298, -86.1581, -93.6091, -97.3301, -85.7585,
          -90.0715, -70.2553, -76.6122, -71.0589, -83.0458,
          -93.2650, -90.1848, -94.5786, -108.5007, -95.9980,
          -115.1398, -71.4548, -74.1724, -106.6056, -74.0059,
          -80.8431, -96.7898, -82.9988, -97.5164, -122.6765,
          -75.1652, -71.4128, -81.0348, -96.7311, -90.0490,
          -95.3698, -111.8910, -73.2121, -75.9780, -122.3321, 
          -81.6326, -87.9065, -104.8202)

pop.city.US <- data.frame(most.pop.city, states, lat, long)
write.csv(pop.city.US, file = 'most-pop-cities.csv', row.names = FALSE)

# desired format: city, lat, long, avg. rating
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
    limit <- 50
    offset <- 0
    categories = food.type
    
    (url <-
        modify_url(yelp, path = c("v3", "businesses", "search"),
                   query = list(location = location, categories = categories, limit = limit, offset = 0)))
    
    res <- GET(url, add_headers('Authorization' = paste("bearer", token)))
    
    response.content <- httr::content(res, "text", encoding = "UTF-8")
    body.data <- fromJSON(response.content) #%>% as.data.frame()
    test <- is.data.frame(body.data$businesses)
    
    results <- body.data$businesses
    # 
    # results.coord.lat <- results$coordinates$latitude
    # results.coord.long <- results$coordinates$longitude
    # results.coord <- data.frame(results.coord.lat, results.coord.long, stringsAsFactors = FALSE)
    
    results.info <- results %>% select(name, rating, price)
    for (i in 1:1) {
      (url <-
         modify_url(yelp, path = c("v3", "businesses", "search"),
                    query = list(location = location, categories = categories, limit = limit, offset = 50 * i)))
      res <- GET(url, add_headers('Authorization' = paste("bearer", token)))
      
      response.content <- httr::content(res, "text", encoding = "UTF-8")
      more.results <- fromJSON(response.content) #%>% as.data.frame()
      if (!is.data.frame(body.data$businesses)) {
        break
      }
      
      more.results.info <- body.data$businesses %>% select(name, rating, price) #rating, coordinates)#, location, price)
      results.info <- rbind(results.info, more.results.info) 
    }
    
    # for (i in 1:2) {
    #   (url <-
    #      modify_url(yelp, path = c("v3", "businesses", "search"),
    #                 query = list(location = location, categories = categories, limit = limit, offset = 50 * i)))
    #   res <- GET(url, add_headers('Authorization' = paste("bearer", token)))
    #   
    #   response.content <- httr::content(res, "text", encoding = "UTF-8")
    #   more.results <- fromJSON(response.content) #%>% as.data.frame()
    #   if (!is.data.frame(body.data$businesses)) {
    #     break
    #   }
    #   
    #   more.results <- body.data$businesses
    #   results.coord.lat <- more.results$coordinates$latitude
    #   results.coord.long <- more.results$coordinates$longitude
    #   more.results.coord <- data.frame(results.coord.lat, results.coord.long, stringsAsFactors = FALSE)
    #   results.coord <- rbind(results.coord, more.results.coord) 
    # }
    
    results.name <- results.info$name
    results.rating <- results.info$rating
    results.price <- results.info$price
    # results.coord.lat <- results.coord$results.coord.lat
    # results.coord.long <- results.coord$results.coord.long
    total.results <- data.frame(results.name, results.rating, results.price, stringsAsFactors = FALSE) 
    #  results.coord.lat, results.coord.long, stringsAsFactors = FALSE) 
    
    most.pop.city <- city
    mean.rating <- mean(results.rating)
    output <- data.frame(most.pop.city, mean.rating, stringsAsFactors = FALSE)
    pop.city.US <- merge(pop.city.US, output, all = TRUE)
    return (pop.city.US)
  }
  
  list.df <- lapply(most.pop.city, AvgRating, food.type=food.type.input)
  
  test <- reduce(list.df, full_join, by = c('most.pop.city','states', 'lat', 'long', 'mean.rating')) %>% 
    filter(!is.na(mean.rating))
  
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showland = TRUE,
    landcolor = toRGB("gray95"),
    subunitcolor = toRGB("gray85"),
    countrycolor = toRGB("gray85"),
    countrywidth = 0.5,
    subunitwidth = 0.5
  )
  
  p <- plot_geo(test, locationmode= 'USA-states',lat = ~lat, lon = ~long)  %>% 
    add_markers(
      z = ~mean.rating, locations = ~states,
      text = ~paste('Most populated city:', most.pop.city, 'Rating:', mean.rating),
      color = ~mean.rating,
      hoverinfo = 'text'
    ) %>%
    layout(
      title = "Test", geo = g
    )
  
  return (p)
}