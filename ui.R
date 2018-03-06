library("dplyr")
library("ggplot2")
library("shiny")


my.ui <- fluidPage (
  
  titlePanel("World Happiness Ranking"),
  h1("Group Project - INFO 201"), 
  h2("Jeongvin, Tanya, Madison"),
  strong("Introduction to data - "),
  p("Our group utilized a data set called 'World Happiness Report' which is gathered by
     Gallup World Poll to create an evaluation on the ranking of each nations happiness. 
    It was first published in 2012 and continuously updated each year, except 2014. The most 
    current data set is 2017, which ranks 155 countries that participated by their happiness levels. 
    Unfortunately, the data set available to the public only ranges from 2015-2017. 
    This record is gaining momentum to be used in government policy and different fields as it is a numerical data 
    to how the citizens feel as they are in their country. It has even been used in United Nation to celebrate International 
    day of Happiness. This data set is continuously improving to explain the personal and national variations in happiness. 
    The data set contains multiple information that is utilized in calculating the Happiness Rank. 
    It is organized in the order of ranking of happiness, although the specific values do not impact the total
    rank these values may give an explanation to their standing in rank.  The specific values range from economic 
    production, social support, life expectancy, freedom, absence of corruption and generosity.  All these values
    are part of the data set which are ranked from 0 - 10, the worst to the best respectively. Dystopia Residual is an 
    average taken from the different variable provided and calculated to show how close a nation is 
    in Dystopia."),
  wellPanel(
    helpText(   a("Click Here to go to Data Set",href="https://www.kaggle.com/unsdsn/world-happiness", target = "blank")
    )
  ),
  
  sidebarLayout(
    sidebarPanel(
      
      radioButtons("chosen.year", label = "Pick a Year", choices = c("2017", "2016", "2015")),
      
      selectInput("chosen.category", label = "Choose a Category", choices = c("Southeastern Asia", "Sub-Saharan Africa", 
                                                                              "Southern Asia", "Eastern Asia", "Western Europe", 
                                                                              "North America","Australia and New Zealand", 
                                                                              "Middle East and Northern Africa", 
                                                                              "Latin America and Caribbean",
                                                                              "Central and Eastern Europe"))

             
    ),
    
    mainPanel(
      p("To start our investigation, we questioned if there would be a correlation of one region having a higher happiness 
      rank in comparison to others, and if those regions would rate themselves the with the highest dystopia residual. As a group
     we created some assumptions that guided our research. We hypothesized that regions near Europe and North America would have
     the highest rank due to the large number of developed nations. For this assumption, we correlated economic and living 
    condition as a strong indication to a happier nation. Along with this, we predicated that those with higher happiness score
    would have higher Dystopia Residual as they would be the farthest away from dystopia. To explore these questions, two graphs
  were created to develop some insights. Both can be filtered using the different region and the year. The dystopia vs 
  Happiness Score graph is influenced greatly by the different region as some regions only contained couple countries. 
  It is crucial to be aware to not allow the lack of data to influence the analysis that can be done with 
        the information provided."), 
      
    strong("Do certain regions rank higher than others?"),
      
     p("This question is explored by using a histogram that is color coded by the different
       regions that are provided within the data set. This histogram provided a more visually stimulating 
       representative of the regions that were ranked higher than a map. With this 
       it was easily to see that all three years, Western Europe continuously ranked the highest.
       On the other spectrum, the lowest ranking nations were those in the regions of Latin America
       and Sub-Saharan Africa. It seems as if our group's assumption of happiness with monetary 
       values were being represented as truth to a certain extent. Those nations that were popular
       for tourism and had a higher living standard seemed to continuously be rated higher by the
       citizens. However, there must be a discretion made that we cannot generalize the whole region 
       as some nation, be acting as outliers. With this result, our group concluded that there was a 
       strong correlation to developed nations and their rate of happiness."),
      plotOutput('graph'),
      
     strong("Do happier regions rate them farther from Dystopia?"),
     
     p("With specific regions being ranked higher, we questioned if these regions would have 
       the highest Dystopia Residual meaning they would be the farthest away from dystopia. The finding 
       with the visualization was quite interesting. When you look at the Western Europe region, the 
       smooth line indicates that the higher the happiness score a nation has, the farther away from dystopia 
       the nation is. - which aligned with our predictions.  However different regions of the world did not 
       align with the same assumption. Asia and Africa showed a line trend where the peak of Dystopia Residual 
       was near when the happiness score was closer to 5, and those who ranked the highest had a lower 
       residual indicating that those nations saw their nation closer to dystopia than nations who ranked below them.
       After searching for a reason, it can be assumed to an extent that  the way happiness is assumed can vary due to 
       cultural differences, we cannot place a single definition and rank each nation. Even though the highest-ranking 
       nation may lead in wealth, life expectancy, freedom and more, this finding was a indication that there must be a 
       different aspect not explored within this data set that led them to believe they were closer to Dystopia than their 
       neighboring nations. It seems as a further investigation from a sociology perspective might help to resolve some answers."), 
     
      
     plotOutput('plot'),
    
     p("This table is a data table that represent the data shown up above [Dystopia Residual and Happiness 
       Score]. You can clearly see that not all regions follow the hypothesized trend of highest ranking nations to 
       have the higher Dystopia Residual."),
     
     verbatimTextOutput("info")
      
    )
  )
  
) 