library(shiny)
source('merging.R')

my.ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      radioButtons("chosen.year", label = "Select Year for World Happiness Report", 
                   choices = c("15", "16", "17")),
      selectInput("region", label = "Select Region to View", 
                  choices = c("Australia and New Zealand", "Central and Eastern Europe", "Eastern Asia",
                              "Latin America and Caribbean", "Middle East and Northern Africa", 
                              "North America", "Southeastern Asia", "Southern Asia", "Sub-Saharan Africa",
                              "Western Europe"))
    ),
    mainPanel(
      plotOutput('graph')
    )
  )
)

shinyUI(my.ui)