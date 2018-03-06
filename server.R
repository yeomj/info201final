library("dplyr")
library("ggplot2")
library("shiny")

source('merging.R')

my.server <- function(input, output) {
  
  output$plot <- renderPlot({
    # Filters the data for only regions 
    filter <- full.data %>% 
      filter(Region == input$chosen.category) 
    
    # Filters for the chosen year and makes the smooth and jitter for grah 
    if(input$chosen.year =='2017') {
      p <- ggplot(data = filter ) +
        geom_smooth(aes(x = filter$Happiness.Score.17, y = filter$Dystopia.Residual.17, color = filter$Happiness.Rank.17)) + 
        geom_jitter(aes(x = filter$Happiness.Score.17, y = filter$Dystopia.Residual.17, color = filter$Happiness.Rank.17), size = 6) + 
        labs(
          x = "Happiness Score (2017)", 
          y = "Dystopia Residual (2017)", 
          color = "Happiness Rank (2017)") 
      
    } else if(input$chosen.year == '2016') { # Filters for the chosen year and makes the graph 
      p <-  ggplot(data = filter) +
        geom_smooth(aes(x = filter$Happiness.Score.16, y = filter$Dystopia.Residual.16, color = filter$Happiness.Rank.16)) + 
        geom_jitter(aes(x = filter$Happiness.Score.16, y = filter$Dystopia.Residual.16, color = filter$Happiness.Rank.16), size = 6) + 
        labs(title ="Dystopian Residual in comparison Happiness Score",  
             x = "Happiness Score (2016)", 
             y = "Dystopia Residual (2016)", 
             color = "Happiness Rank (2016)")
    } else {  # Filters for the chosen year and makes the graph 
      p <- ggplot(data = filter) +
        geom_smooth(aes(x = filter$Happiness.Score.15, y = filter$Dystopia.Residual.15, color = filter$Happiness.Rank.15)) + 
        geom_jitter(aes(x = filter$Happiness.Score.15, y = filter$Dystopia.Residual.15, color = filter$Happiness.Rank.15), size = 6) + 
        labs(title = 'Dystopian Residual in comparison Happiness Score',  
             x = "Happiness Score (2015)", 
             y = "Dystopia Residual (2015)", 
             color = "Happiness Rank (2015)") 
    }
    
    # Adjust the title so it is placed in the middle and bolded 
    final.p <- p + 
      ggtitle("Dystopian Residual in comparison to Happiness Score") +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
    
    return(final.p) # returns the plot to ui 
  })
  
  
  output$graph <- renderPlot({
    
    # Filter for year and makes histogram 
    if(input$chosen.year == '2017') {
      pp <- ggplot(full.data, aes(x = Happiness.Score.17, fill = Region)) +
        geom_histogram()
      
    } else if (input$chosen.year == '2016') {
      pp <- ggplot(full.data, aes(x = Happiness.Score.16, fill = Region)) +
        geom_histogram()
      
    } else {
      pp <- ggplot(full.data, aes(x = Happiness.Score.15, fill = Region)) +
        geom_histogram()
    }
    final.region <- pp + 
      ggtitle("Happiness Rank showcased in Region") +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
    
    return(final.region) # Returns the historgram 
  })
  
  
  selected <- reactive({
    
    # Filter for year that selects certain rows 
    if(input$chosen.year == '2017') {
      this <- full.data %>% 
        filter(Region == input$chosen.category) %>% 
        select(Country, Happiness.Rank.17, Happiness.Score.17, Dystopia.Residual.17)
    } else if(input$chosen.year == '2016') {
      this <- full.data %>% 
        filter(Region == input$chosen.category) %>% 
        select(Country, Happiness.Rank.16, Happiness.Score.16, Dystopia.Residual.16)
    } else {
      this <- full.data %>% 
        filter(Region == input$chosen.category) %>% 
        select(Country, Happiness.Rank.15, Happiness.Score.15, Dystopia.Residual.15)
    }
    
    return(this) # returns the reactive statement 
  }) 
  
  output$info <- renderPrint({
    return(selected()) # prints the text as a text box 
  })
  
}