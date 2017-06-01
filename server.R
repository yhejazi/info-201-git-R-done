library(shiny)
library(tm)
library(SnowballC)
library(wordcloud)
source("./scripts/wordCloud.R")
source("./scripts/stackedBar.R")
source("./scripts/map.R")
source("./scripts/scatter.R")

shinyServer(function(input, output) {
  output$wordcloud <- renderPlot({
    corpus <- MakeWordCloud(input$radio)
    wordcloud_rep <- repeatable(wordcloud)
    wordcloud_rep(corpus, scale = c(6, 1), max.words = 100, random.order = FALSE, colors = brewer.pal(5, "Accent"), min.freq = 2)
  })
  
  output$stackedBar <- renderPlotly({
    return(MakeStackedBar(input$stackedInputCity))
  })
  
  output$map <- renderPlotly({
    return(MakeMap(input$food))
  })

  output$scatter <- renderPlotly({
  return(MakeScatter())
  })
  
  output$CityMap <- renderPlotly({
    return(MakeCityMap())
  })
  
  output$mytable <- renderDataTable({favorites3})
  
  output$stackedBarSideText <- renderUI(
    HTML("<p> After selecting one of the major cities listed, the stacked bar chart will display the the 
         top 50 restaurants of each category and how they compare to one another in distribution of
         price levels.</p>")
    )
})
