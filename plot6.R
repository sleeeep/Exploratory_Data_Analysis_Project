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
emissions_of_Balti_and_Los_from_motor <- filter(emissions_from_motor, fips == '24510' | fips == '06037')
emissions_of_Balti_and_Los_from_motor_change <- aggregate(emissions_of_Balti_and_Los_from_motor$Emissions, 
                                                  by = list(emissions_of_Balti_and_Los_from_motor$year, emissions_of_Balti_and_Los_from_motor$fips),
                                                  FUN = sum)
names(emissions_of_Balti_and_Los_from_motor_change) <- c('year','city','total_emissions_from_motor')

png(filename = './figure/plot6.png')
p <- ggplot(data = emissions_of_Balti_and_Los_from_motor_change,
            aes(x = year, y = total_emissions_from_motor, col = city)) + 
    geom_line(size = 1) +
    geom_point(size = 3) +
    labs(x = 'year') + 
    labs(y = expression('PM'[2.5]*' Emissions')) + 
        labs(title = 'Total Emissions from Motor Vehicle\n in Baltimore and Los Angeles from 1999 to 2008') + 
    theme(plot.title = element_text(size = rel(1.5), lineheight = 0.9, colour = 'deepskyblue4', hjust = 0.5)) + 
    ## 更改图例的标签时，因为上面分组用了col，所以下面要用scale_color_discrete；
    ## 如果上面分组用fill，下面用scale_fill_discrete
    scale_color_discrete(labels = c('Los Angeles','Baltimore'))
p
dev.off()