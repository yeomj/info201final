library(shiny)
library(ggplot2)
library(dplyr)
source('merging.r')
my.server <- function(input, output) {
  observeEvent(input$happiness.rank, {
    rank.range <- range(input$happiness.rank)
  } 
  
  )  
  fc.filter <- reactive({
    data <- freedom.corruption %>%
      filter(Happiness.Rank.17 > rank.range[1] & Happiness.Rank.17 < range.rank[2])
    return(data)
  })
  output$fc.scatter <- renderPlot({ 
    if(input$chosen.year == "15") { 
      fc.scatter <- ggplot(data = fc.filter(), mapping = aes(x = "Freedom.15", y = "Trust..Government.Corruption..15")) +
        geom_jitter() 
    } else if(input$chosen.year == "16") {
      fc.scatter <- ggplot(data = fc.filter(), aes(x = "Freedom.16", y = "Trust..Government.Corruption..16")) + 
        geom_jitter()
    } else { 
      fc.scatter <- ggplot(data = fc.filter(), aes(x = "Freedom.17", y = "Trust..Government.Corruption..17")) +
        geom_jitter()
    }
    return(fc.scatter)
  })

  
  
  
}


shinyServer(my.server)