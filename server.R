library(shiny)
library(ggplot2)
library('dplyr')
source('merging.R')

my.server <- function(input, output){
  output$graph <- renderPlot ({
    wealthy.generosity1 <- filter(wealthy.generosity, Region == input$region)
    if(input$chosen.year == "15") {
      wg.plot <- ggplot(data = wealthy.generosity1, mapping = aes(x = "Economy..GDP.per.Capita..15",
                                                                 y = "Generosity.15")) +
        geom_jitter()
    } else if(input$chosen.year == "16") {
      wg.plot <- ggplot(data = wealthy.generosity1, aes(x = "Economy..GDP.per.Capita..16",
                                                       y = "Generosity.16")) +
        geom_jitter()
    } else {
      wg.plot <- ggplot(data = wealthy.generosity1, aes(x = "Economy..GDP.per.Capita..17",
                                                       y = "Generosity.17")) +
        geom_jitter()
    }
    return(wg.plot)
  })
}

shinyServer(my.server)