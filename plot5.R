## -----------------------------
## Course Project of Exploratory Data Analysis
## author: Yan He
## April 14, 2018
## -----------------------------
setwd ('/Users/heyan/Documents/Data Science/Exploratory Data Analysis/course project 2')
library(tidyverse)

NEI <- readRDS('./data/summarySCC_PM25.rds')
SCC <- readRDS('./data/Source_Classification_Code.rds')

motor_index <- grep('motor', SCC$Short.Name, ignore.case = TRUE)
motor_SCC <- SCC$SCC[motor_index] 
emissions_from_motor <- filter(NEI,SCC %in% motor_SCC)
emissions_of_Balti_from_motor <- filter(emissions_from_motor, fips == '24510')
emissions_of_Balti_from_motor_change <- aggregate(emissions_of_Balti_from_motor$Emissions, 
                                        by = list(emissions_of_Balti_from_motor$year),
                                        FUN = sum)
names(emissions_of_Balti_from_motor_change) <- c('year','emissions_of_Balti_from_motor')

png(filename = './figure/plot5.png')
p <- ggplot(data = emissions_of_Balti_from_motor_change,
            aes(x = year, y = emissions_of_Balti_from_motor)) + 
    geom_line(size = 1, col = 'deepskyblue4') +
    geom_point(colour = 'deepskyblue4',size = 3) +
    labs(x = 'year') + 
    labs(y = expression('PM'[2.5]*' Emissions')) + 
    labs(title = expression('PM'[2.5]*" Emissions of Baltimore from Motor Vehicle")) + 
    theme(plot.title = element_text(hjust = 0.5))
p
dev.off()