## -----------------------------
## Course Project of Exploratory Data Analysis
## author: Yan He
## April 14, 2018
## -----------------------------
setwd ('/Users/heyan/Documents/Data Science/Exploratory Data Analysis/course project 2')
library(tidyverse)

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

png(filename = './figure/plot2.png')
Baltimore_data <- filter(NEI, fips == '24510')
total_emissions_of_Baltimore <- aggregate(Baltimore_data$Emissions, 
                                          by = list(Baltimore_data$year), 
                                          FUN = sum)
names(total_emissions_of_Baltimore) <- c('year','total_emissions_of_Bal')
with(total_emissions_of_Baltimore,
     plot(year, total_emissions_of_Bal, type ='b', lty = 2, col = 'red',
          main = 'Total Emissions of Baltimore from 1999 to 2008',
          ylab = expression('PM'[2.5]*' Emissions')))
dev.off()