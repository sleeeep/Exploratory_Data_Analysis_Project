## -----------------------------
## Course Project of Exploratory Data Analysis
## author: Yan He
## April 14, 2018
## -----------------------------
setwd ('/Users/heyan/Documents/Data Science/Exploratory Data Analysis/course project 2')
library(tidyverse)

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

Baltimore_data <- filter(NEI, fips == '24510')
total_emissions_of_Baltimore <- aggregate(Baltimore_data$Emissions, 
                                          by = list(Baltimore_data$year, Baltimore_data$type), 
                                          FUN = sum)
names(total_emissions_of_Baltimore) <- c('year','type','total_emissions_of_Bal')

png(filename = './figure/plot3.png')
p <- ggplot(data = total_emissions_of_Baltimore,
       aes(x = year, y = total_emissions_of_Bal, col = type)) + 
    geom_line(size = 1.5) +
    labs(x = 'year') + 
    labs(y = expression('PM'[2.5]*' Emissions')) + 
    labs(title = expression('PM'[2.5]*'Emissions of Four Types in Baltimore')) + 
    theme(plot.title = element_text(hjust = 0.5)) 
p
dev.off()
