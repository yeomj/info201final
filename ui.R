library("dplyr")
library("ggplot2")
library("shiny")
source('merging.R')
source('server.R')

my.ui<- fluidPage(
  
  titlePanel("Group"), 
  
  
  sidebarLayout(
    sidebarPanel(
      
      radioButtons("chosen.year", label = "Pick a Year", choices = c("2017", "2016", "2015")),
      
      selectInput("chosen.category", label = "Choose a Category", choices = c("Southeastern Asia", "Sub-Saharan Africa", 
                                                                              "Southern Asia", "Eastern Asia", "Western Europe", 
                                                                              "North America","Australia and New Zealand", 
                                                                              "Middle East and Northern Africa", 
                                                                              "Latin America and Caribbean",
                                                                              "Central and Eastern Europe"))
      
      
    ),
    
    mainPanel(
      
      p("The purple represnts Happiness Score vs Freedom (which we expect to be higher) and 
        the maroon represent Happiness Score vs Corruption. I did the facet just to see how each 
        variable was in relation to Happiness Score and it seems as it has the relationship I would 
        expect since I expect the freedom to be placed higher than corruption."),
      plotOutput('corruption'),
      
      p("I just did a area graph to show the relations, if it was in complete correlation it should have a 
        positive slope be a straight line. It actually is for North America, and Austria/New Zealand region 
        but some other regions dont which I think you could probably do some analysis as to why that might be. 
        Hopefully this is helpful! "),
      plotOutput('plot')
      

  
  
)
)
)

