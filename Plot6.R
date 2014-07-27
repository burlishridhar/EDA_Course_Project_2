# ####################################################################################################
# Plot 6
# Answer: Baltimore had a greater change in emissions in 2002 and 2008.
# However, Los Angeles had a huge change in emissions in 2005 which was much, much bigger than the change in Baltimore
# ####################################################################################################

### IMPORTANT :     PLEASE ENSURE THAT THE FILES summarySCC_PM25.rds AND Source_Classification_Code.rds 
###                            ARE IN THE SAME WORKING DIRECTORY

### Clear the workspace ###
rm(list = ls())

library(ggplot2)
library(plyr)

### Read the data from the files ###
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Find the indexes and SCC values which have 'motor' in the 'Short.Name' field ###
motorIndex <- grep("motor", SCC$"Short.Name", ignore.case=T)
SCCmotorSccs <- SCC[motorIndex,"SCC"]

# Subsetting on baltimore city (fips=24510) and LA (fips=06037)
# Based on valid SCCs from the previous data frame
NEI_motor_data <- NEI[(NEI$fips %in% c("24510","06037")) & (NEI$SCC %in% SCCmotorSccs), ]

#Filter out from all emissions on above criteria and calculate aggregate
NEI_motor_data_agg <- aggregate(NEI_motor_data$Emissions, list(Year=NEI_motor_data$year, 
                                               Location=as.factor(NEI_motor_data$fips)), sum)

# Calculate the geomtric mean of the summed up emission quantities
NEI_motor_data_agg_2 <- ddply(NEI_motor_data_agg,"Location",transform, Growth=c(0,(exp(diff(log(x)))-1)*100))

# Replace the fips code with the city names
NEI_motor_data_agg_2 <- as.data.frame(sapply(NEI_motor_data_agg_2,gsub,pattern="24510",replacement="Baltimore"))
NEI_motor_data_agg_2 <- as.data.frame(sapply(NEI_motor_data_agg_2,gsub,pattern="06037",replacement="Los Angeles"))


###  Open the PNG graphics device ###
png(file="Plot6.png", width = 600, height = 600, units = "px")

# Use the ggplot2 system to plot the variation of emissions

qplot(x=Year, y=Growth, fill=Location,
      data=NEI_motor_data_agg_2, geom="bar", stat="identity",
      position="dodge"
      , xlab = "Year"
      , ylab = "Variation in percent (geometric mean)"

      , main = "Variation of PM2.5 Emissions by city"
)

### Close the graphics device ###
dev.off()