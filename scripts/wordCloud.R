library(httr)
library(jsonlite)
library(dplyr)
library(tm)
library(SnowballC)
library(wordcloud)

MakeWordCloud <- function(food.type) {
  # res <- POST("https://api.yelp.com/oauth2/token",
  #             body = list(grant_type = "client_credentials",
  #                         client_id = "qbG0Ss5H65OolR_HMBgBBw",
  #                         client_secret = 
  #                           "2WvCr07mZmkcoOk173Uh9hdah1jWG0MlkpOWEoMUCF1btxTWEnm1tJeXNw6vq2Re"))
  # token <- httr::content(res)$access_token
  # 
  # yelp <- "https://api.yelp.com"
  # #term <- "coffee"
  # location <- "WA"
  # limit <- 50
  # offset <- 0
  # categories <- food.type
  # 
  # (url <-
  #     modify_url(yelp, path = c("v3", "businesses", "search"),
  #                query = list(location = location, categories = categories, limit = limit, offset = 0)))
  # #> [1] "https://api.yelp.com/v3/businesses/search?term=coffee&location=Vancouver%2C%20BC&limit=3"
  # res <- GET(url, add_headers('Authorization' = paste("bearer", token)))
  # 
  # response.content <- httr::content(res, "text", encoding = "UTF-8")
  # body.data <- fromJSON(response.content)
  # test <- is.data.frame(body.data$businesses)
  # 
  # results <- jsonlite::flatten(body.data$businesses) %>% 
  #            dplyr::select(name)
  # 
  # for (i in 1:3) {
  #   (url <-
  #      modify_url(yelp, path = c("v3", "businesses", "search"),
  #                 query = list(location = location, categories = categories, limit = limit, offset = 50 * i)))
  #   res <- GET(url, add_headers('Authorization' = paste("bearer", token)))
  #   
  #   response.content <- httr::content(res, "text", encoding = "UTF-8")
  #   body.data <- fromJSON(response.content)
  #   if (!is.data.frame(body.data$businesses)) {
  #     break
  #   }
  #   
  #   more.results <- jsonlite::flatten(body.data$businesses) %>%
  #                   select(name)
  #   results <- rbind(results, more.results)
  # }
  
  results <- results <- read.csv(paste0("./data/wc_", food.type, ".csv"), stringsAsFactors = FALSE)
  
  corpus <- Corpus(VectorSource(results)) %>% 
            tm_map(content_transformer(tolower)) %>% 
            tm_map(removePunctuation) %>% 
            tm_map(PlainTextDocument) %>% 
            tm_map(removeWords, c("list", "character", "the", "and"))
  
  return(corpus)
}

###################
#  res <- POST("https://api.yelp.com/oauth2/token",
#             body = list(grant_type = "client_credentials",
#                         client_id = "qbG0Ss5H65OolR_HMBgBBw",
#                         client_secret =
#                           "2WvCr07mZmkcoOk173Uh9hdah1jWG0MlkpOWEoMUCF1btxTWEnm1tJeXNw6vq2Re"))
# token <- httr::content(res)$access_token
# 
# yelp <- "https://api.yelp.com"
# #term <- "coffee"
# location <- "WA"
# limit <- 50
# offset <- 0
# categories <- "tradamerican"
# 
# (url <-
#     modify_url(yelp, path = c("v3", "businesses", "search"),
#                query = list(location = location, categories = categories, limit = limit, offset = 0)))
# #> [1] "https://api.yelp.com/v3/businesses/search?term=coffee&location=Vancouver%2C%20BC&limit=3"
# res <- GET(url, add_headers('Authorization' = paste("bearer", token)))
# 
# response.content <- httr::content(res, "text", encoding = "UTF-8")
# body.data <- fromJSON(response.content)
# test <- is.data.frame(body.data$businesses)
# 
# results <- flatten(body.data$businesses) %>%
#            select(name)
# 
# for (i in 1:3) {
#   (url <-
#       modify_url(yelp, path = c("v3", "businesses", "search"),
#                  query = list(location = location, categories = categories, limit = limit, offset = 50 * i)))
#   res <- GET(url, add_headers('Authorization' = paste("bearer", token)))
# 
#   response.content <- httr::content(res, "text", encoding = "UTF-8")
#   body.data <- fromJSON(response.content)
#   if (!is.data.frame(body.data$businesses)) {
#     break
#   }
# 
#   more.results <- flatten(body.data$businesses) %>%
#                   select(name)
#   results <- rbind(results, more.results)
# }
# 
# results <- unique(results)
# write.csv(results, paste0("./data/wc_", categories, ".csv"))

results <- read.csv("./data/wc_thai.csv", stringsAsFactors = FALSE)

corpus <- Corpus(VectorSource(results)) %>%
        tm_map(content_transformer(tolower)) %>%
        tm_map(removePunctuation) %>%
        tm_map(PlainTextDocument) %>%
        tm_map(removeWords, c("the", "and"))


 wordcloud(corpus, random.order = FALSE, colors = brewer.pal(11, "Spectral"), min.freq = 2)