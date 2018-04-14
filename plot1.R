## -----------------------------
## Course Project of Exploratory Data Analysis
## author: Yan He
## April 14, 2018
## -----------------------------
setwd ('/Users/heyan/Documents/Data Science/Exploratory Data Analysis/course project 2')
library(tidyverse)

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

png(filename = './figure/plot1.png')
total_emissions <- aggregate(NEI$Emissions, by = list(NEI$year), FUN = 'sum')
names(total_emissions) <- c('year','total_emissions')
with(total_emissions,
     barplot(total_emissions, 
             names.arg = year, 
             main = 'Total Emissions  in 1999 to 2008',
             ylab = expression('PM'[2.5] * ' Emissions'),
             horiz = FALSE))


dev.off()

