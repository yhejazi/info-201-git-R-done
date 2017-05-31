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
                                radioButtons(inputId = "radio", label = "Food Categories",
                                             choices = list("Chinese" = "chinese", "Japanese" = "japanese", "Korean" = "korean", "Thai" = "thai",
                                                            "Mediterranean" = "mediterranean", "Indian" = "indpak", "Mexican" = "mexican",
                                                            "American (Traditional)" = "tradamerican"),
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
                                radioButtons(inputId = 'stackedInput', label = "Select a State", 
                                            choices = list("Washington" = "WA"),
                                            selected = "WA")
                              ),
                              mainPanel(
                                plotlyOutput("stackedBar")
                              )
                              
                            )),
                    tabPanel('Map',
                             titlePanel('Restaurant Ratings Map'),
                             sidebarLayout(
                               sidebarPanel(
                                 selectInput('food', label = 'Select Cuisine',
                                             choices = list('American' = 'tradamerican',
                                                            'Mexican' = 'mexican',
                                                            'Italian' = 'italian',
                                                            'Mediterranean' = 'mediterranean',
                                                            'Chinese' = 'chinese',
                                                            'Japanese' = 'japanese',
                                                            'Indian' = 'indpak'), 
                                             selected = 'tradamerican')
                               ),
                               mainPanel(
                                 plotlyOutput('map')
                               )
                             )),
              tabPanel("Meet The Team",
                       includeMarkdown("MeetTheTeam.rmd")    
              )
)
)
)
)