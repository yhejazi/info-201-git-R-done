library(tm)
library(SnowballC)
library(wordcloud)

# Creates a word cloud for restaurants of the given food type in Washington.
MakeWordCloud <- function(food.type) {
  results <- results <- read.csv(paste0("./data/wc_", food.type, ".csv"), stringsAsFactors = FALSE)
  
  # transforms word cloud to have no punctuations and all lower case
  corpus <- Corpus(VectorSource(results)) %>% 
            tm_map(content_transformer(tolower)) %>% 
            tm_map(removePunctuation) %>% 
            tm_map(PlainTextDocument) %>% 
            tm_map(removeWords, c("list", "character", "the", "and"))
  
  return(corpus)
}