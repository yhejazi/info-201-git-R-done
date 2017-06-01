library(httr)
library(purrr)
library(jsonlite)
library(dplyr)
library(plotly)
library(tidyr)

MakeScatter<- function() {
  # Write csv file for Yelp API data
  
  # res <- POST("https://api.yelp.com/oauth2/token",
  #             body = list(grant_type = "client_credentials",
  #                         client_id = "iXvoLjOm6wir50Rq0XrwZg",
  #                         client_secret = 
  #                           "2jifA0p0BWQROgO6Kmarl9bBc6WFwLH3r8SP9fzFmbrHkq98suQRgAP3OoBduC4u"))
  # token <- httr::content(res)$access_token
  # 
  # yelp <- "https://api.yelp.com"
  # term <- "restaurant"
  # location <- "Washington"
  # limit <- 50
  # results <- data.frame()
  # 
  # # gets 300 results from Washington (out of 302)
  # for(i in 1:6) {
  #   (url <-
  #       modify_url(yelp, path = c("v3", "businesses", "search"),
  #                  query = list(term = term, location = location, limit = limit, offset = i*50)))
  #   #> [1] "https://api.yelp.com/v3/businesses/search?term=coffee&location=Vancouver%2C%20BC&limit=3"
  #   res <- GET(url, add_headers('Authorization' = paste("bearer", token)))
  #   
  #   response.content <- httr::content(res, "text")
  #   body.data <- fromJSON(response.content)
  #   
  #   loop.results <- jsonlite::flatten(body.data$businesses)
  #   results <- rbind(results, loop.results)
  # }
  # 
  # # remove restaurants without a price
  # results <- filter(results, price != 'N/A')
  # 
  # # create levels to convert price to measurement
  # levels <- c(1, 2, 3, 4, 5)
  # price <- c('$', '$$', '$$$', '$$$$', '$$$$$')
  # priced.results <- data.frame(price, price.levels = levels, stringsAsFactors = FALSE)
  # results <- left_join(results, priced.results, by = 'price')
  # 
  # # unnest lists from 'categories'
  # results <- unnest(results, categories)
  # 
  # # filter to food titles of interest
  # results.filtered <- select(results, rating, price.levels, title) %>%
  #   filter(title %in% c('Mexican', 'Chinese', 'Japanese', 'Italian', 'American (Traditional)', 'Korean',
  #                       'Indian', 'Thai', 'Mediterranean', 'German'))
  # 
  # # get average rating and price
  # result.sum <- group_by(results.filtered, title) %>%
  #   summarise(avg.rating = round(mean(rating), 2), avg.price = round(mean(price.levels), 2), count = n())
  # 
  # write.csv(result.sum, file = "scatterWA.csv")
  
  result.sum <- read.csv('./data/scatterWA.csv')
  # plot data
  # scatterplot of average price vs average rating, comparing types of food served in restaurants
  p <- plot_ly(result.sum, x = ~avg.price, y = ~avg.rating, type = 'scatter', color = ~title) %>%
    layout(
      title = "Washington Restaurant Avg. Price vs Rating",
      xaxis = list(title="Price Level"),
      yaxis = list(title="Rating"),
      annotations=list(
        list(
          x=1.34,
          y=1.03,
          text='Type of food',
          xref='paper',
          yref='paper',
          showarrow=FALSE
        )
      )
    )
  
  return(p)
}
