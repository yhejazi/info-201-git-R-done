library(shiny)
library(plotly)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("united"),
  (navbarPage('INFO 201 Project',
                   tabPanel("Project Description",
                        includeMarkdown("ProjectDocumentation.md")    
                            ),
                   
                   tabPanel('Word Cloud',
                            titlePanel("Yelp stuff"),
                            
                            sidebarLayout(
                              
                              sidebarPanel(
                                # Create a dropdown menu for different nutrients
                                # selectInput(inputId = "select", label = "Nutrient", choices = c("Fiber", "Carbohydrate", "Sugar"), selected = "Fiber"),
                                
                                # Create radio buttons for different manufacturers
                                radioButtons(inputId = "radio", label = "Food Categories",
                                             choices = list("Chinese" = "chinese", "Japanese" = "japanese", "Korean" = "korean"),
                                             selected = "chinese")
                                
                                
                              ),
                              # Plots the data and writes a description of the page.
                              mainPanel(
                                plotOutput("wordcloud")
                                
                              )
                            )
                   ),
                   tabPanel('StackedBar',
                            titlePanel('Stacked Bar Chart'),
                            sidebarLayout(
                              sidebarPanel(
                                
                              ),
                              mainPanel(
                                plotlyOutput("stackedBar")
                              )
                              
                            )),
              tabPanel("Meet The Team",
                       includeMarkdown("MeetTheTeam.rmd")    
              )
)
)
)
)
