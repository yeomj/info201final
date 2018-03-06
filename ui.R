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
                              "Western Europe", "World"))
    ),
    mainPanel(
      h1("Do wealthier countries have higher levels of generosity?"),
      p("For our first analysis, we decided to see if there was any correlation between a country's
         wealth, measured by its Gross Domestic Product (GDP) per Capita, and its generosity, which
        is meaured by their total spending on social welfare. We wanted to see if different regions,
        which often share some cultural and economic qualities, would have some correlation between
        these two factors. We predicted that as wealth increased, so would generosity. Since we are
        only studying data from three years, however, any correlation we would find would be rather
        weak, and we would need to explore data from a larger number of years to find any trends or
        a stronger correlation between these factors."),
      strong("Is there any correlation between wealth and generosity?"),
      p("Below, you will find a dot plot comparing wealth to generosity, separated by region. When
        studying correlation, we ignored the graphs from Australia & New Zealand, Eastern Asia, and
        North America because there were not enough countries in each region to truly find any correlation
        between these values. As for the other regions, we could not find much correlation between
        wealth and generosity. In four of the regions (Latin America & the Caribbean, Middle East and
        North Africa, Southeastern Asia, and Western Europe), we could find no evidence of correlation
        between wealth and generosity in any of the three years. In Central & Eastern Europe and Sub-Saharan
        Africa, we found a slight negative correlation, meaning that as wealth increased, generosity 
        decreased, which was the opposite of our expected result. The only region with a slight positive
        correlation was Southern Asia, which includes the countries of the Indian Sub-Continent. Overall,
        our data cannot come to a decisive solution, as we have limited data and cannot find a very strong
        correlation between these two factors, generosity and wealth. More research would need to be done
        on the topic to come to a conclusion."),
      h2("Graph of Wealth by GDP per Capita and Generosity in Chosen Region and Year"),
      plotOutput('graph')
    )
  )
)

shinyUI(my.ui)