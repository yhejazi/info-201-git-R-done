library(httr)
library(purrr)
library(jsonlite)
library(plotly)
library(ggplot2)

#Returns a stacked bar chart that has the number of restaurants of a specific type within given city
#and uses price range as a stacked variable
MakeStackedBar <- function(location) {
  cityname <- str_replace_all(location, "[^[:alnum:]]", "") #take out punctuation to get cityname for file
  city_data <- read.csv(file = paste0("./data/", cityname, "PriceData.csv")) #find file associated with city
  
  #Create stacked bar chart with price levels as traces
  stacked <- plot_ly(city_data, x = ~type, y = ~one, type = 'bar', name = "Inexpensive") %>%
    add_trace(y = ~city_data$two, name = 'Moderate') %>%
    add_trace(y = ~city_data$three, name = 'Pricey') %>%
    add_trace(y = ~city_data$four, name = 'Ultra High-End') %>%
    layout(title = paste0(location, ": # Restaurants by Type w/Price Level"), 
           xaxis = list(title = 'Type of Food'), yaxis = list(title = 'Count'),
           barmode = 'stack', margin = list(b = 100))
  return (stacked)
}

#Below was the inital code to gather and export city data as .csv files for easy access

# res <- POST("https://api.yelp.com/oauth2/token",
#             body = list(grant_type = "client_credentials",
#                         client_id = "iXvoLjOm6wir50Rq0XrwZg",
#                         client_secret =
#                           "2jifA0p0BWQROgO6Kmarl9bBc6WFwLH3r8SP9fzFmbrHkq98suQRgAP3OoBduC4u"))
# token <- httr::content(res)$access_token
# 
# yelp <- "https://api.yelp.com"
# 
# list.categories <- c("mexican", "tradamerican", "italian", "chinese", "japanese",
#                      "korean", "indpak", "thai", "mediterranean", "german")
# 
# list.categories.rownames <- c("Chinese", "German", "Indian", "Italian", "Japanese", "Korean", "Mediterranean",
#                               "Mexican", "Thai", "Traditional American")
# 
# list.locations <- c("Seattle, WA", "San Francisco, CA", "New York, NY", "Chicago, IL", "Houston, TX")
# 
# 
# #Functions numRestaurantsPrice() and mergePriceCol() used in for loops that initially gather data from each city
# 
# #Function numRestaurantsPrice creates dataframe that has a types of food and the number of restaurants
# #per type in given price range
# numRestaurantsPrice <- function(input.price, priceColName) {
#   df <- restaurant.list %>% 
#     select(price, type) %>%
#     group_by(type) %>% 
#     filter(price == input.price) %>% 
#     summarise(priceColName = n())
#   colnames(df) <- c("type", priceColName)
#   return(df)
# }

# #Function mergePriceCol merges columns from dataframes created from numRestaurantsPrice() function
# mergePriceCol <- function(df1, df2, newColName) {
#   merged <- df1 %>% mutate(colname = 0) %>% 
#     merge(df2, all = TRUE) %>%
#     group_by(type) %>%
#     mutate(colname = sum(colname))
#   colnames(merged)[ncol(merged)] <- newColName
#   merged <- select(merged, -colname)
#   return (merged)
# }
# 
# #For loop to get all categories in one table for each city
# for(city in list.locations){
#   restaurant.list <- data.frame()
#   for(type in list.categories){
#     print(paste("collecting data for", type, city))
#     (url <-
#         modify_url(yelp, path = c("v3", "businesses", "search"),
#                    query = list(location = city, categories = type, limit = 50)))
#     res <- GET(url, add_headers('Authorization' = paste("bearer", token)))
#     
#     response.content <- httr::content(res, "text", encoding = "UTF-8")
#     body.data <- fromJSON(response.content)
#     
#     results <- jsonlite::flatten(body.data$businesses)
#     
#     temp.table <- results %>% select(id, name, review_count, rating, price) %>% mutate(type = type)
#     restaurant.list <- rbind(restaurant.list, temp.table)
#   }
#   
#   #complete restaurant list
#   restaurant.list <- unique(restaurant.list)
#   
#   #count how many of each type of food is in each pricing category
#   price1 <- numRestaurantsPrice('$', "one")
#   price2 <- numRestaurantsPrice('$$', "two")
#   price3 <- numRestaurantsPrice('$$$', "three")
#   price4 <- numRestaurantsPrice('$$$$', "four")
#   
#   #merge individual pricing data into one dataframe
#   all.prices <- mergePriceCol(price1, price2, "two") %>%
#     mergePriceCol(price3, "three") %>% 
#     mergePriceCol(price4, "four")
#   
#   all.prices[is.na(all.prices)] <- 0 #replace all N/A values with 0
#   all.prices$type <- list.categories.rownames #rename rownames with proper labels
#   
#   cityname <- str_replace_all(city, "[^[:alnum:]]", "") #take out punctuation to get cityname for file
#   
#   write.csv(all.prices, file = paste0("data/", cityname, "PriceData.csv")) #write file with cities restaurant and pricing data
# }