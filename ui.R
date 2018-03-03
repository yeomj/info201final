library(shiny)
source('merging.R')

my.ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      radioButtons(year, "Select Year for World Happiness Report", selected = "2015", choiceNames = 
                    c("2015", "2016", "2017"), choiceValues = c("15", "16", "17"))
    ),
    mainPanel(
      plotOutput(wg.graph, "90%", "90%")
    )
  )
)

shinyUI(my.ui)