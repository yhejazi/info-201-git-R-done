
library("ggplot2")
library("dplyr")
library('jsonlite')
library('httr')
library('knitr')
library('plotly')
library('stringr')

MakeTable<-function(){
favorites<- read.csv("./favorites.csv")
favorites3<-favorites%>%
  select(State, Favorite, most.pop.city)
write.csv(favorites3, file = "favorited3.csv",row.names=FALSE)
ggplot(favorites, aes(x = Stare, y = Favorite, z = most.pop.city
               label = lab, colour = b)) +
  geom_text(size = 3.5) + 
  theme_minimal() + 
  scale_y_continuous(breaks=NULL)+
  theme(panel.grid.major = element_blank(), legend.position = "none",
        panel.border = element_blank(), axis.text.x =  element_blank(),
        axis.ticks =  element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank()) 

}