library(httr)
library(purrr)
library(jsonlite)
library(plotly)

#Creates a stacked bar chart that searches for a maximum of 150 entries for each of the
#10 listed categories and uses the pricing as the stacked variable
MakeStackedBar <- function() {
  res <- POST("https://api.yelp.com/oauth2/token",
              body = list(grant_type = "client_credentials",
                          client_id = "iXvoLjOm6wir50Rq0XrwZg",
                          client_secret =
                            "2jifA0p0BWQROgO6Kmarl9bBc6WFwLH3r8SP9fzFmbrHkq98suQRgAP3OoBduC4u"))
  token <- httr::content(res)$access_token

  yelp <- "https://api.yelp.com"
  location <- "WA"
  categories <- "chinese"
  list.categories <- c("mexican", "tradamerican", "italian", "chinese", "japanese",
                       "korean", "indpak", "thai", "mediterranean", "german")

  #for loop to get all categories in one table
  final <- data.frame()
  for(type in list.categories){
    for(i in 1:3) {
      #repeat 3 times to get a max of 150 entries per category
      (url <-
         modify_url(yelp, path = c("v3", "businesses", "search"),
                    query = list(location = location, categories = type, limit = 50)))
      res <- GET(url, add_headers('Authorization' = paste("bearer", token)))

      response.content <- httr::content(res, "text", encoding = "UTF-8")
      body.data <- fromJSON(response.content)

      results <- jsonlite::flatten(body.data$businesses)

      temp.table <- results %>% select(id, name, review_count, rating, price) %>% mutate(type = type)
      final <- rbind(final, temp.table)
    }
  }

  final <- unique(final)

  #Create stacked bar graph with type of food as x axis, and price as stacked
  stacked <- ggplot(data = final) +
    geom_bar(mapping= aes(x = type, fill = price)) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))

  return (stacked)
}

#test <- MakeStackedBar()

# res <- POST("https://api.yelp.com/oauth2/token",
#             body = list(grant_type = "client_credentials",
#                         client_id = "iXvoLjOm6wir50Rq0XrwZg",
#                         client_secret = 
#                           "2jifA0p0BWQROgO6Kmarl9bBc6WFwLH3r8SP9fzFmbrHkq98suQRgAP3OoBduC4u"))
# token <- content(res)$access_token
# 
# yelp <- "https://api.yelp.com"
# location <- "WA"
# categories <- "chinese"
# list.categories <- c("mexican", "tradamerican", "italian", "chinese", "japanese",
#                      "korean", "indpak", "thai", "mediterranean", "german")
# 
# #for loop to get all categories in one table
# final <- data.frame()
# for(type in list.categories){
#   for(i in 1:3){ #repeat 3 times to get a max of 150 entries per category
#     (url <-
#        modify_url(yelp, path = c("v3", "businesses", "search"),
#                   query = list(location = location, categories = type, limit = 50)))
#     res <- GET(url, add_headers('Authorization' = paste("bearer", token)))
#     
#     response.content <- content(res, "text", encoding = "UTF-8")
#     body.data <- fromJSON(response.content)
#     
#     results <- flatten(body.data$businesses)
#     
#     temp.table <- results %>% select(id, name, review_count, rating, price) %>% mutate(type = type)
#     final <- rbind(final, temp.table)
#   }
# }
# 
# final <- unique(final) 
# 
# #Create stacked bar graph with type of food as x axis, and price as stacked
# stacked <- ggplot(data = final) +
#   geom_bar(mapping= aes(x = type, fill = price)) + 
#   theme(axis.text.x = element_text(angle = 90, hjust = 1))