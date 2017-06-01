library(shiny)
library(plotly)
library(shinythemes)
library(markdown)

# source("./scripts/CityMap.R")

shinyUI(fluidPage(theme = shinytheme("united"),
  (navbarPage('U.S. Restaurant Diversity',
                   tabPanel("Project Description",
                        mainPanel(
                        includeMarkdown("./ProjectDescription/ProjectDocumentation.md")    
                            )),
    
                   
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
                                plotOutput("wordcloud"),
                                includeMarkdown("./GraphDescriptions/wordcloud_description.md")
                              )
                            )
                   ),
                   tabPanel('Type/Price',
                            titlePanel('Type w/Price Levels by City'),
                            sidebarLayout(
                              sidebarPanel(
                                uiOutput("stackedBarSideText"),
                                radioButtons(inputId = 'stackedInputCity', label = "Select a Major City", 
                                            choices = list("Seattle, WA", "San Francisco, CA", 
                                                           "New York, NY", "Chicago, IL", "Houston, TX", 
                                                           "Atlanta, GA", "Boston, MA", "Denver, CO", "Los Angeles, CA",
                                                           "Phoenix, AZ", "Portland, OR", "Salt Lake City, UT"),
                                            selected = "Seattle, WA")
                              ),
                              mainPanel(
                                plotlyOutput("stackedBar"),
                                includeMarkdown('./GraphDescriptions/stackedbar-analysis.md')
                              )
                              
                            )),
                    tabPanel('Rating Trends Map',
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
                                 plotlyOutput('map'),
                                 includeMarkdown('./GraphDescriptions/map-analysis.md')
                               )
                             )),
              
              tabPanel("Price vs. Rating",
                       titlePanel("Scatter of Average Price to Average Rating"),
                       
                       # Show a plot of the generated distribution
                       mainPanel(
                         plotlyOutput("scatter"),
                         includeMarkdown("./GraphDescriptions/scatter-description.md")
                       )
              ),
              
              # tabPanel("Breaking it Up By City",
              #          titlePanel("Breaking it Up By City"),
              #          # Show a plot of the generated distribution
              #            includeMarkdown("./GraphDescriptions/CityMapDescription.md"),
              #            plotlyOutput("CityMap"),
              #            dataTableOutput('mytable'),
              #             includeMarkdown("./GraphDescriptions/Inferences.md")
              #            
              #          
              #          
              # ),
              tabPanel("Meet The Team",
                       includeMarkdown("./MeetTeam/MeetTheTeam.md")    
              )
)
)
)
)