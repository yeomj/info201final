library("dplyr")
library("ggplot2")
library("shiny")

source('merging.R')
my.server <- function(input, output) {
  
  this.data <- reactive({
    # Filters the data for only regions 
    filtered <- full.data %>% 
      filter(Region == input$chosen.category) 
  })

  
  output$plot <- renderPlot({
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
    
  
  output$corruption <- renderPlot({
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

}