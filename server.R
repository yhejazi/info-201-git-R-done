library(shiny)
library(tm)
library(SnowballC)
library(wordcloud)
source("./scripts/wordCloud.R")
source("./scripts/stackedBar.R")
source("./scripts/map.R")
source("./scripts/scatter.R")
source("./scripts/CityMap.R")

shinyServer(function(input, output) {
  
  # Plots word cloud of restaurant names
  output$wordcloud <- renderPlot({
    corpus <- MakeWordCloud(input$radio)
    wordcloud_rep <- repeatable(wordcloud)
    wordcloud_rep(corpus, scale = c(6, 1), max.words = 100, random.order = FALSE, colors = brewer.pal(5, "Accent"), min.freq = 2)
  })
  
  output$stackedBar <- renderPlotly({
    return(MakeStackedBar(input$stackedInputCity))
  })
  
  # Plots rating trend map
  output$map <- renderPlotly({
    return(MakeMap(input$food))
  })
  
  # Plots rating vs price scatter plot
  output$scatter <- renderPlotly({
  return(MakeScatter())
  })
  
  # Plots map of popular cities' favorite type of food
  output$CityMap <- renderPlotly({
    return(MakeCityMap())
  })
  
  output$stackedBarSideText <- renderUI(
    HTML("<p> After selecting one of the major cities listed, the stacked bar chart will display the the 
         top 50 restaurants of each category and how they compare to one another in distribution of
         price levels.</p>")
    )
})
