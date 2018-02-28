library('dplyr')

hap.17 <- read.csv("data/hap.2017.csv", stringsAsFactors = FALSE)

hap.16  <- read.csv("data/hap.2016.csv", stringsAsFactors = FALSE)

hap.15  <- read.csv("data/hap.2015.csv", stringsAsFactors = FALSE)

countries.data <- read.csv("data/countries.csv", stringsAsFactors = FALSE)

two.years <- left_join(hap.17, hap.16)

add.more <- left_join(two.years, hap.15)

full.happiness <- full_join(add.more, countries.data)

full.data <- full.happiness %>% 
             filter(Happiness.Rank.17 != 'NA')
