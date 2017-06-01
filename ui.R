library(shiny)
library(plotly)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("united"),
  (navbarPage('INFO 201 Project',
                   tabPanel("Project Description",
                        includeMarkdown("./ProjectDescription/ProjectDocumentation.md")    
                            ),
                   
                   tabPanel('Word Cloud',
                            titlePanel("Word Cloud"),

                            sidebarLayout(

                              sidebarPanel(
                                radioButtons(inputId = "radio", label = "Food Categories",
                                             choices = list("Chinese" = "chinese", "Japanese" = "japanese", "Korean" = "korean", "Thai" = "thai",
                                                            "Mediterranean" = "mediterranean", "Indian" = "indpak", "Mexican" = "mexican",
                                                            "American (Traditional)" = "tradamerican", "Italian" = "italian"),
                                             selected = "chinese")


                              ),
                              # Plots the data and writes a description of the page.
                              mainPanel(
                                plotOutput("wordcloud")

                              )
                            )
                   ),
                   tabPanel('Type/Price',
                            titlePanel('Type w/Price Levels by City'),
                            sidebarLayout(
                              sidebarPanel(
                                radioButtons(inputId = 'stackedInputCity', label = "Select a State", 
                                            choices = list("Seattle, WA", "San Francisco, CA", 
                                                           "New York, NY", "Chicago, IL", "Houston, TX"),
                                            selected = "Seattle, WA")
                              ),
                              mainPanel(
                                plotlyOutput("stackedBar")
                              )
                              
                            )),
                    tabPanel('Map',
                             titlePanel('Restaurant Ratings Map'),
                             sidebarLayout(
                               sidebarPanel(
                                radioButtons('food', label = 'Select Cuisine',
                                             choices = list('Chinese' = 'chinese',
                                                            'Japanese' = 'japanese',
                                                            'Korean' = 'korean',
                                                            'Thai' = 'thai',
                                                            'Mediterranean' = 'mediterranean',
                                                            'Indian' = 'indpak',
                                                            'American' = 'tradamerican',
                                                            'Italian' = 'italian'), 
                                             selected = 'chinese')
                               ),
                               mainPanel(
                                 plotlyOutput('map')
                               )
                             )),
              
              tabPanel("Scatter",
                       titlePanel("Scatter of Average Price to Average Rating"),
                       
                       # Show a plot of the generated distribution
                       mainPanel(
                         plotlyOutput("scatter")
                       )
              ),
              
              tabPanel("Meet The Team",
                       includeMarkdown("./MeetTeam/MeetTheTeam.rmd")    
              )
)
)
)
)