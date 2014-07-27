# #################################################
# Plot 3
# Answer: Emissions have decreased for : NON-POINT , NON-ROAD and ON-ROAD
# Emissions have increased for : POINT
# #################################################

### IMPORTANT :     PLEASE ENSURE THAT THE FILES summarySCC_PM25.rds AND Source_Classification_Code.rds 
###                            ARE IN THE SAME WORKING DIRECTORY

### Clear the workspace ###
rm(list = ls())

require(ggplot2)

### Read the data from the files ###
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Filter the data specific to Baltimore City (fips == 24510) ###
Baltimore_City_Data <- NEI[(NEI$fips == 24510),]

###  Use the aggregate function to calculate the sum of Emissions by year ###
Total_Baltimore_City_PM25_Data <- 
  aggregate(Emissions ~ year * type, Baltimore_City_Data, sum)

### Convert the type vector into a factor ###
Total_Baltimore_City_PM25_Data$type <- factor(Total_Baltimore_City_PM25_Data$type)

### load the ggplot2 library ###
library(ggplot2)

###  Open the PNG graphics device ###
png(file="Plot3.png", width = 600, height = 600, units = "px")

### Call the quick Plot function from the ggplot2 package ###
qplot(year , Emissions , data = Total_Baltimore_City_PM25_Data
      , col = type
      , geom="path"
      , main="PM2.5 Emissions per Source by Year"
      , xlab = "Year"
      , ylab = "Total PM2.5 Emissions (in tonnes)"
      )

### Close the graphics device ###
dev.off()
