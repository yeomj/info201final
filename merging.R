library('dplyr')

happiness.data <- read.csv("data/happiness.2017.csv", stringsAsFactors = FALSE)

countries.data <- read.csv("data/countries.csv", stringsAsFactors = FALSE)

full.happiness <- full_join(happiness.data, countries.data)
