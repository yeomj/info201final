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
      
      p("The purple represnts Happiness Score vs. Freedom and 
        the maroon represent Happiness Score vs. Corruption. A high amount of freedom and trust in government are both two important factors of happiness. 
        Therefore, we included this facet to see how each 
        variable was represented in relation to Happiness Score. From the data, it appears that
        the regions of North America, Western Europe, the Middle East and Northern Africa consider higher
        levels of freedom and trust in government as important factors in their overall happiness. Other regions 
        such as Central and Eastern Europe and Sub-Saharan Africa experience lower overall happiness scores and no apparent
relationship between freedom/corruption and happiness scores. This indicates that there may be more pressing factors at hand
resulting in the low happiness scores."),
      plotOutput('corruption'),
      
      p("We included this area graph to show the relationship between the variables of freedom and corruption.  
        We predicted that countries with higher trust in goverment - low perceived corruption - would experience more freedom.
        When viewing the data points, it appears that countries with higher perceived levels of corruption
        factor in freedom more in their overall happiness. From this data, we found that higher trust in government
        positively correlates with higher freedom, dsiplaying a positive slope in the trend line."),
      plotOutput('plot')
      

  
  
)
)
)

