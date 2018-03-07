library("dplyr")
library("ggplot2")
library("shiny")

source('merging.R')

# Sorry - we had to do if/else because our data set when merged was named all different depending on which computer 
#was on so this was the easiet way to fix the issue when we merged it all togheter. 

my.server <- function(input, output) {

  # TAB 1 - DYSTOPIA AND HAPPINESS 
  
  # Plots the regions depending on their hapiness score 
  output$plot <- renderPlot({
    # Filters the data for only regions 
    filter <- full.data %>% 
      filter(Region == input$chosen.category) 
    
    # Filters for the chosen year and makes the smooth and jitter for grah 
    if(input$chosen.year =='2017') {
      p <- ggplot(data = filter ) +
        geom_smooth(aes(x = filter$Happiness.Score.17, y = filter$Dystopia.Residual.17, color = filter$Happiness.Rank.17)) + 
        geom_jitter(aes(x = filter$Happiness.Score.17, y = filter$Dystopia.Residual.17, color = filter$Happiness.Rank.17), size = 6) + 
        labs(x = "Happiness Score (2017)", 
          y = "Dystopia Residual (2017)", 
          color = "Happiness Rank (2017)") 
      
    } else if(input$chosen.year == '2016') { # Filters for the chosen year and makes the graph 
      p <-  ggplot(data = filter) +
        geom_smooth(aes(x = filter$Happiness.Score.16, y = filter$Dystopia.Residual.16, color = filter$Happiness.Rank.16)) + 
        geom_jitter(aes(x = filter$Happiness.Score.16, y = filter$Dystopia.Residual.16, color = filter$Happiness.Rank.16), size = 6) + 
        labs(x = "Happiness Score (2016)", 
             y = "Dystopia Residual (2016)", 
             color = "Happiness Rank (2016)")
    } else {  # Filters for the chosen year and makes the graph 
      p <- ggplot(data = filter) +
        geom_smooth(aes(x = filter$Happiness.Score.15, y = filter$Dystopia.Residual.15, color = filter$Happiness.Rank.15)) + 
        geom_jitter(aes(x = filter$Happiness.Score.15, y = filter$Dystopia.Residual.15, color = filter$Happiness.Rank.15), size = 6) + 
        labs(x = "Happiness Score (2015)", 
             y = "Dystopia Residual (2015)", 
             color = "Happiness Rank (2015)") 
    }
    
    # Adjust the title so it is placed in the middle and bolded 
    final.p <- p + 
      ggtitle("Dystopian Residual in comparison to Happiness Score") +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
    
    return(final.p) # returns the plot to ui 
  })
  
  # Plots the dystopia level dependent on their happiness score 
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
  
  
  # Makes a data table that is expressing what was shown 
  # on the dystopia graph 
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
  
# TAB 2 - FREEDOM AND CORRUPTION 
  
  # Filters the data for only regions 
  this.data <- reactive({
    filtered <- full.data %>% 
      filter(Region == input$chosen.category) 
  })

  # Plots the Freedom and Corruption as area 
  output$corruption <- renderPlot({
    if(input$chosen.year =='2017') {
      g <- ggplot(data = this.data(), aes(x = Freedom.17, y = Trust..Government.Corruption..17))+ 
        geom_jitter(colour = "black") + 
        geom_area(fill = "light blue") + 
        labs( x = "Freedom (2017)",
               y = "Trust in Government (2017)")
    } else if (input$chosen.year == '2016') {
      g <- ggplot(data = this.data(), aes(x = Freedom.16, y = Trust..Government.Corruption..16))+ 
        geom_jitter(colour = "black") + 
        geom_area(fill = "light blue") + 
        labs( x = "Freedom (2016)",
               y = "Trust in Government (2016)")
    } else {
      g <- ggplot(data = this.data(), aes(x = Freedom.15, y = Trust..Government.Corruption..15))+ 
        geom_jitter(colour = "black") + 
        geom_area(fill = "light blue") + 
        labs( x = "Freedom (2015)",
               y = "Trust in Government (2015)")
    }
    
    final.g <- g + 
      ggtitle("Correlation Between Freedom and Corruption") +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
    return(final.g)
   })
    
  
   # Plots all the country with their freedom/corruption
  # and happiness level 
  output$facet <- renderPlot({
    if(input$chosen.year == '2017'){
      only.corrupt <- ggplot(data = full.data) + 
        geom_point(mapping = aes(x = Happiness.Score.17, y = Freedom.17), colour = 'purple') + 
        facet_wrap(~Region)+
        geom_point(mapping = aes(x = Happiness.Score.17, y = Trust..Government.Corruption..17, colour = "Corruption"), colour = "maroon") + 
         facet_wrap(~Region)+ 
        labs(x = "Happiness Score (2017)", 
             y = "Freedom/Corruption (2017)") 
    } else if (input$chosen.year == '2016') {
      only.corrupt <- ggplot(data = full.data) + 
        geom_point(mapping = aes(x = Happiness.Score.16, y = Freedom.16), colour = 'purple') + 
        facet_wrap(~Region)+
        geom_point(mapping = aes(x = Happiness.Score.16, y = Trust..Government.Corruption..16, colour = "Corruption"), colour = "maroon") + 
        facet_wrap(~Region)+ 
        labs( x = "Happiness Score (2016)",
              y = "Freedom/Corruption (2016)") 
    } else {
      only.corrupt <- ggplot(data = full.data) + 
        geom_point(mapping = aes(x = Happiness.Score.15, y = Freedom.15), colour = 'purple') + 
        facet_wrap(~Region)+
        geom_point(mapping = aes(x = Happiness.Score.15, y = Trust..Government.Corruption..15, colour = "Corruption"), colour = "maroon") + 
        facet_wrap(~Region)+ 
        labs( x = "Happiness Score (2015)",
              y = "Freedom/Corruption (2015)") 
    }
    
    final.only.corrupt <- only.corrupt + 
      ggtitle("Hapiness Score compared to Freedom and Corruption") +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
    return(final.only.corrupt)
  })

# TAB 3 - WEALTH AND GENEROSITY 
  
  # Plots to see the correlation between specified regions 
  output$region <- renderPlot({
    if(input$chosen.year == '17') {
      region <- ggplot(full.data, aes(x = Economy..GDP.per.Capita..17,
                                      y = Generosity.17, colour = Region)) +
        geom_jitter(size = 3) + 
        geom_smooth() + 
        labs( x = "Economy (2016)",
              y = "Generosity (2016)") 
      
    } else if (input$chosen.year == '16') {
      region <- ggplot(full.data, aes(x = Economy..GDP.per.Capita..16,
                                      y = Generosity.16, colour = Region)) +
        geom_jitter(size = 3) + 
        geom_smooth() + 
        labs( x = "Economy (2016)",
              y = "Generosity (2016)") 
      
    } else {
      region <- ggplot(full.data, aes(x = Economy..GDP.per.Capita..15,
                                      y = Generosity.15, colour = Region)) +
        geom_jitter(size = 3) + 
        geom_smooth() + 
        labs( x = "Economy (2016)",
              y = "Generosity (2016)") 
    }
    
    final.region <- region + 
      ggtitle("Correlation between wealth and generosity based on Region") +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
    
    return(final.region) 
  })
  
  
  # Plots to see the graph in ranking to find correlation 
  output$rank <- renderPlot({
    if(input$chosen.year == '17') {
      rank <- ggplot(full.data, aes(x = Economy..GDP.per.Capita..17,
                                    y = Generosity.17, colour = Happiness.Rank.17)) +
        geom_jitter() + 
        geom_smooth() + 
        labs( x = "Economy (2017)",
              y = "Generosity (2017)") 
      
    } else if (input$chosen.year == '16') {
      rank <- ggplot(full.data, aes(x = Economy..GDP.per.Capita..16,
                                    y = Generosity.16, colour = Happiness.Rank.16)) +
        geom_jitter() + 
        geom_smooth() + 
        labs( x = "Economy (2016)",
              y = "Generosity (2016)") 
      
    } else {
      rank <- ggplot(full.data, aes(x = Economy..GDP.per.Capita..15,
                                    y = Generosity.15, colour = Happiness.Rank.15)) +
        geom_jitter() + 
        geom_smooth() + 
        labs( x = "Economy (2015)",
              y = "Generosity (2015)") 
    }
    
    final.rank <- rank + 
      ggtitle("Correlation between wealth and generosity based on Rank") +
      theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"))
    
    return(final.rank) 
  })
  
}


