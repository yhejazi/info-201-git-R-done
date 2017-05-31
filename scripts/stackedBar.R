library(httr)
library(purrr)
library(jsonlite)
library(plotly)
library(ggplot2)

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
  restaurant.list <- data.frame()
  for(type in list.categories){
    # for(i in 1:3) {
    #repeat 3 times to get a max of 150 entries per category
    print(paste("collecting data for", type))
    (url <-
        modify_url(yelp, path = c("v3", "businesses", "search"),
                   query = list(location = location, categories = type, limit = 50)))
    res <- GET(url, add_headers('Authorization' = paste("bearer", token)))
    
    response.content <- httr::content(res, "text", encoding = "UTF-8")
    body.data <- fromJSON(response.content)
    
    results <- jsonlite::flatten(body.data$businesses)
    
    temp.table <- results %>% select(id, name, review_count, rating, price) %>% mutate(type = type)
    restaurant.list <- rbind(restaurant.list, temp.table)
    #}
  }
  
  restaurant.list <- unique(restaurant.list)
  
  #count how many of each type of food is in each pricing category
  price1 <- restaurant.list %>% select(price, type) %>% group_by(type) %>% filter(price == '$') %>% summarise("one" = n())
  price2 <- restaurant.list %>% select(price, type) %>% group_by(type) %>% filter(price == '$$') %>% summarise("two" = n())
  price3 <- restaurant.list %>% select(price, type) %>% group_by(type) %>% filter(price == '$$$') %>% summarise("three" = n())
  price4 <- restaurant.list %>% select(price, type) %>% group_by(type) %>% filter(price == '$$$$') %>% summarise("four" = n())
  
  all.prices <- price1 %>%  #merge first 2 price counts
    mutate("two"= 0) %>%
    merge(price2, all = TRUE) %>% 
    group_by(type) %>%
    mutate(two = sum(two)) %>%
    
    mutate("three"= 0) %>% #merge price counts up to third price category
    merge(price3, all = TRUE) %>%
    group_by(type) %>%
    mutate(three = sum(three)) %>%
    
    mutate("four" = 0) %>% #merge price counts up to fourth price category
    merge(price4, all=TRUE) %>%
    group_by(type) %>%
    mutate(four = sum(four)) %>%
    filter(!is.na(one))
  
  p <- plot_ly(all.prices, x = ~type, y = ~one, type = 'bar', name = 'one') %>% 
    add_trace(y = ~all.prices$two, name = 'two') %>% 
    add_trace(y = ~all.prices$three, name = 'three') %>% 
    add_trace(y = ~all.prices$four, name = 'four') %>% 
    layout(yaxis = list(title = 'Count'), barmode = 'stack')
  return (p)
}

test <- MakeStackedBar()
print('done')
