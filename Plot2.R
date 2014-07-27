# #######################################################################################
# Plot 2
# Answer: Yes. The total emissions in Baltimore City have decreased from 1999 to 2008. However, there was an 
# increase from 2002 to 2005
# #######################################################################################

### IMPORTANT :     PLEASE ENSURE THAT THE FILES summarySCC_PM25.rds AND Source_Classification_Code.rds 
###                            ARE IN THE SAME WORKING DIRECTORY

### Clear the workspace ###
rm(list = ls())

### Read the data from the files ###
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Filter the data specific to Baltimore City (fips == 24510) ###
Baltimore_City_Data <- NEI[(NEI$fips == 24510),]

###  Use the aggregate function to calculate the sum of Emissions by year ###
Total_Baltimore_City_PM25_Data <- 
  aggregate(Baltimore_City_Data$Emissions ~ Baltimore_City_Data$year, Baltimore_City_Data, sum)


###  Open the PNG graphics device ###
png(file="Plot2.png", width = 500, height = 500, units = "px")


### Plot the data using Base Plotting System ###

plot(Total_Baltimore_City_PM25_Data 
     , type = "o"                                  # For a Line Chart
     , col  = c(1:4)                               # To get different Colors for different data points
     , pch  = 19                                   # plotting symbol
     , ylab = "Total PM2.5 Emissions (in tonnes)"  # X Axis Label
     , xlab = "Year"                               # Y Axis Label
     , cex  = 1.3)                                 # Scaling Factor
title("Total PM2.5 Emissions in Baltimore City, Maryland by year")                    # Add a Title to the plot
legend('topright'                                         # Add a position for the legend
       , legend = Total_Baltimore_City_PM25_Data[,1]                # Add the legend Data
       , pch=19, col=c(1:4))             # Add Plotting Symbol, colors and scale factor

### Close the graphics device ###
dev.off()
