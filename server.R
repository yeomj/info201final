library(shiny)
library(ggplot2)
source('merging.R')

my.server <- function(input, output){
  output$wg.plot <- renderPlot ({
    wg.plot <- ggplot(data = wealthy.generosity) +
      geom_jitter(mapping = aes(x = paste0("Economy..GDP.per.Capita..", input$year),
                                y = paste0("Generosity.", input$year),
                                color = 'Region')) +
      geom_smooth(mapping =  aes(x = paste0("Economy..GDP.per.Capita..", input$year),
                                 y = paste0("Generosity.", input$year)))
    return(wg.plot)
  })
}

shinyServer(my.server)