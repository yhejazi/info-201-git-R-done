#adds in needed packages
library("ggplot2")
library("dplyr")
library('jsonlite')
library('httr')
library('knitr')
library('plotly')
library('stringr')


MakeCityMap<-function(){
#sorts the data from a csv file and selects the needed columns
favorites<- read.csv("./data/favorites.csv")
favorites2<-favorites%>%
  select(State, Favorite, most.pop.city, lat, long, Rating)

#creates a map that has markers that are colored by the type of food and which are sized by that type of food popularity
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showland = TRUE,
    landcolor = toRGB("black"),
    subunitwidth = 1,
    countrywidth = 1,
    subunitcolor = toRGB("white"),
    countrycolor = toRGB("white")
  )
  
  #Fills in the details of the map which include shooting locations, number of people injured, and number of people killed. The colors of the map were chosen to communicate the serious tone of the  data. 
  p <- plot_geo(favorites2, locationmode = 'USA-states', lat = ~lat, lon = ~long) %>%
    add_markers(
      x = ~long, y = ~lat, size = ~Rating, color = ~Favorite, colors = 'Paired', opacity = 1,
      hoverinfo = "text",
      text = ~paste(favorites2$Favorite, "<br />", favorites2$most.pop.city,
                    "<br />", favorites2$State)
      
    ) %>%
    
    #Adds a title to the map
    layout(title = 'Highest Rated Food Type by Highest Populated City per State', geo = g)
  
  return(p)
}

MakeCityMap()
