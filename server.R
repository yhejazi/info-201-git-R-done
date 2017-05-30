library(shiny)
library(dplyr)
library(httr)
library(jsonlite)
library(tm)
library(SnowballC)
library(wordcloud)
source("./scripts/wordCloud.R")
source("./scripts/stackedBar.R")

shinyServer(function(input, output) {
  output$wordcloud <- renderPlot({
    corpus <- MakeWordCloud(input$radio)
    wordcloud_rep <- repeatable(wordcloud)
    wordcloud_rep(corpus, scale = c(6, 1), max.words = 100, random.order = FALSE, colors = brewer.pal(5, "Accent"), min.freq = 2)
  })
  
  output$stackedBar <- renderPlotly({
    return(MakeStackedBar())
  })
  
})