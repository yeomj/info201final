library(shiny)
library(dplyr)
library(ggplot2)
source("merging.R")

my.ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      radioButtons("chosen.year", label = "Select Year for World Freedom vs. Corruption", choices = c("15", "16", "17")),
    sliderInput("happiness.rank", label = "Happiness Ranking", min = 1, max = 155, value = 1)
    ),
      mainPanel(
      plotOutput('fc.scatter'),
      verbatimTextOutput('fc.filter')
    )
  )
)

shinyUI(my.ui)