# ###############################################################
#  Plot 1
#  Answer : Yes. The total PM2.5 emissions have decreased from 1999 to 2008.
# ###############################################################

### IMPORTANT :     PLEASE ENSURE THAT THE FILES summarySCC_PM25.rds AND Source_Classification_Code.rds 
###                            ARE IN THE SAME WORKING DIRECTORY

### Clear the workspace ###
rm(list = ls())

### Read the data from the files ###
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

###  Use the aggregate function to calculate the sum of Emissions by year ###
Total_PM25_Data <- aggregate(NEI$Emissions ~ NEI$year, NEI, sum)


###  Open the PNG graphics device ###
png(file="Plot1.png", width = 500, height = 500, units = "px")

### Plot the data using Base Plotting System ###

plot(Total_PM25_Data 
            , type = "o"                                                     # For a Line Chart
            , col  = c(1:4)                                                 # To get different Colors for different data points
            , pch  = 19                                                     # plotting symbol
            , ylab = "Total PM2.5 Emissions (in tonnes)"  # X Axis Label
            , xlab = "Year"                                                 # Y Axis Label
            , cex  = 1.3)                                                     # Scaling Factor

title("Total PM2.5 Emissions by year")                        # Add a Title to the plot

legend('topright'                                                         # Add a position for the legend
            , legend = Total_PM25_Data[,1]                    # Add the legend Data
            , pch=19, col=c(1:4) , cex = 1.3)                    # Add Plotting Symbol, colors and scale factor

### Close the graphics device ###
dev.off()