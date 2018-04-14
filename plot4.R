## -----------------------------
## Course Project of Exploratory Data Analysis
## author: Yan He
## April 14, 2018
## -----------------------------
setwd ('/Users/heyan/Documents/Data Science/Exploratory Data Analysis/course project 2')
library(tidyverse)

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

coal_index <- grep('coal', SCC$Short.Name, ignore.case = TRUE)
coal_SCC <- SCC$SCC[coal_index] 
emissions_from_coal <- filter(NEI,SCC %in% coal_SCC)
emissions_from_coal_change <- aggregate(emissions_from_coal$Emissions, 
                                        by = list(emissions_from_coal$year),
                                        FUN = sum)
names(emissions_from_coal_change) <- c('year','total_emissions_from_coal')

png(filename = './figure/plot4.png')
p <- ggplot(data = emissions_from_coal_change,
            aes(x = year, y = total_emissions_from_coal)) + 
    geom_line(size = 1, col = 'deepskyblue4') +
    geom_point(colour = 'deepskyblue4',size = 3) +
    labs(x = 'year') + 
    labs(title = expression('PM'[2.5]*"Emissions from 1999 to 2008")) + 
    theme(plot.title = element_text(hjust = 0.5))
p
dev.off()
