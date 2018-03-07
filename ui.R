
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
                                                                              "Central and Eastern Europe", "World"))

             
    ),
    
    mainPanel(
      tabsetPanel(
        
        tabPanel("World Happiness Analysis",
      p("For our investigation, we analyzed whether there was a correlation between regions that have a higher happiness 
      rank, and whether those regions would rate themselves the with the highest dystopia residual. The dystopia 
variable represents an imaginary country with the world's least-happy people, so the residuals serve as a benchmark 
against real countries. As a group, we created some assumptions that guided our research. We hypothesized that regions near Europe and North America would have
     the highest happiness rank due to the large number of developed nations. For this assumption, we correlated economic and living 
    condition as a strong indication to a happier nation. Along with this comparison, we predicated that those with higher happiness scores
    would have higher Dystopia Residual as they would be the farthest away from dystopia. To explore these questions, we created two visualizations
  to gain insight. Both can be filtered using the different region and the year. The dystopia vs 
  Happiness Score graph is influenced greatly by the different region as some regions only contained couple countries. 
  It is crucial to be aware so as not to allow the lack of data to influence the analysis that can be done with 
        the information provided."), 
      
    strong("Do certain regions rank higher than others?"),
      
     p("This question is explored by using a histogram that is color coded by the different
       regions that are provided within the data set. We chose to display a histogram instead of a map because it provided a more visually-stimulating 
       representation of the regions that were ranked higher. With the histogram, 
       it is easy to see that all three years, Western Europe continuously ranked the highest.
       On the other side of the spectrum, the lowest ranking nations were those in the regions of Latin America
       and Sub-Saharan Africa. It seems as if our group's assumption of happiness with monetary 
       values are represented as truth to a certain extent. Those nations that were popular
       for tourism and had a higher living standard seemed to continuously be rated higher by the
       citizens. However, there must be a discretion made that we cannot generalize the whole region 
       as some nations act as outliers. With this result, our group concluded that there was a 
       strong correlation to developed nations and their rate of happiness."),
      plotOutput('graph'),
      
     strong("Do happier regions rate them farther from Dystopia?"),
     
     p("With specific regions being ranked higher, we questioned if these regions would have 
       the highest Dystopia Residual - meaning they would be the farthest away from dystopia. The finding 
       with the visualization was quite interesting. Upon viewing the Western Europe region, the 
       smooth line indicates that the higher the happiness score a nation has, the farther away from dystopia 
       the nation is - which aligned with our predictions.  However, different regions of the world did not 
       align with the same assumption. Asia and Africa showed a line of trend where the peak of Dystopia Residual 
       was near when the happiness score was closer to 5, and those who ranked the highest had a lower 
       residual indicating that those nations saw their nation closer to dystopia than nations who ranked below them.
       After searching for a reason, it can be assumed to an extent that the way happiness is assumed can vary due to 
       cultural differences; we cannot place a single definition and rank each nation. Even though the highest-ranking 
       nation may lead in wealth, life expectancy, freedom and more, this finding was a indication that there must be a 
       different aspect not explored within this data set that led them to believe they were closer to Dystopia than their 
       neighboring nations. It seems as a further investigation from a sociology perspective might help to resolve some answers.
       **Note: Some of the regions did not have enough points to create a smooth line."), 
     
      
     plotOutput('plot'),
    
     p("This table is a data table that represents the data shown above [Dystopia Residual and Happiness 
       Score]. You can clearly see that not all regions follow the hypothesized trend of highest ranking nations to 
       have the higher Dystopia Residual."),
     
     verbatimTextOutput("info")
  ), 
    
    tabPanel( "Correlation between Freedom and Corruption", 
              p("The purple dots on this visualization represnt Happiness Score vs. Freedom and 
        the maroon dots represent Happiness Score vs. Corruption. A high amount of freedom and trust in government are both two important factors of determining happiness. 
                Therefore, we included this facet to see how each 
                variable was represented in relation to Happiness Score. From the data, it appears that
                the regions of North America, Western Europe, the Middle East and Northern Africa consider higher
                levels of freedom and trust in government as important factors in their overall happiness. Other regions 
                such as Central and Eastern Europe and Sub-Saharan Africa experience lower overall happiness scores and no apparent
                relationship between freedom/corruption and happiness scores. This indicates that there may be more pressing factors at hand
                resulting in the low happiness scores."),
              plotOutput('corruption'),
              
              p("We included this area graph to show the relationship between the variables of freedom and corruption.  
                We predicted that countries with higher trust in goverment - low perceived corruption - would experience more freedom.
                When viewing the data points, it appears that countries with higher perceived levels of corruption
                factor in freedom more in their overall happiness. From this data, we found that higher trust in government
                positively correlates with higher freedom, dsiplaying a positive slope in the trend line. As perceived freedom and 
                trust in government are both important factors in a country's overall happiness, this correlation makes sense. 
                However, in some regions (such as the Southeastern Asia region) the correlation is weaker, indicating that in some countries,
                more freedom does not necessarily translate to a more trusted government"),
              plotOutput('facet')
    ), 
  
      tabPanel("Correlation between Wealth and Generosity", 
               h1("Do wealthier countries have higher levels of generosity?"),
               p("For our first analysis, we decided to examine whether there was any correlation between a country's
         wealth - measured by its Gross Domestic Product (GDP) per Capita - and its generosity, which
        is meaured by their total spending on social welfare. We looked to see if different regions,
        which often share some cultural and economic qualities, would have some correlation between
        these two factors. We predicted that as wealth increased, so would generosity. Since we
        only studied data from three years, any correlation we found would be on the weaker
        side. We would need to explore data from a larger number of years to find any trends or
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
               plotOutput('graph2')
        
        
      )
      
      
    )
      
    )
  )
  
) 

   