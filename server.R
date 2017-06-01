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
  
  output$stackedBarSideText <- renderUI(
    HTML("<p> After selecting one of the major cities listed, the stacked bar chart will display the the 
         top 50 restaurants of each category and how they compare to one another in distribution of
         price levels.</p>")
    )
  
  output$stackedBarFindings <- renderUI(
    HTML("<p>These charts make it easier to compare which types of food most likely fall 
         within certain price levels and how this differs across major U.S. cities.</p>
         <p>After comparing the various stacked bar charts created based on different cities, 
         some things we noticed were: </p>
         <ul>
         <li>Japanese and Italian are more likely to have restaurants in the Ultra High-End price level</li>
         <li>In general, Moderate is the most dominate price level across all listed types of food</li>
         <li>New York has the most similar results when comparing the of number of restaurants per category and each type's price levels</li>
         <li>San Francisco, CA appears to have the most restaurants in the Ultra High-End price range </li>
         <li>German is one of the least commonly served food at restaurants</li>
         </ul>")
    )
})
