# ###########################################################################################
# Plot 5
# Answer: The emissions from Motor Vehicle Sources from Baltimore in 1999 and 2008  are approximately at the same level.
#  However, there was a major increase from 1999 to 2002 followed by a major decrease from 2002 to 2008.
# ###########################################################################################

### IMPORTANT :     PLEASE ENSURE THAT THE FILES summarySCC_PM25.rds AND Source_Classification_Code.rds 
###                            ARE IN THE SAME WORKING DIRECTORY

### Clear the workspace ###
rm(list = ls())

### Read the data from the files ###
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Find the indexes and SCC values which have 'motor' in the 'Short.Name' field ###
motorIndex <- grep("motor", SCC$"Short.Name", ignore.case=T)
SCCmotorSccs <- SCC[motorIndex,"SCC"]

### Find the index and data from NEI data frame ###
NEIMotorIndex_Baltimore <- (NEI$SCC %in% SCCmotorSccs & NEI$fips == "24510") 
Baltimore_City_PM25_Data <- NEI[NEIMotorIndex_Baltimore, ]

### Aggregate the data ###
motorEmissions <- aggregate(Emissions ~ year, Baltimore_City_PM25_Data, sum)

###  Open the PNG graphics device ###
png(file="Plot5.png", width = 600, height = 600, units = "px")

### Plot the data using Base Plotting System ###
plot(motorEmissions
     , type="o"
     , pch = 19
     , col = seq(along.with = motorEmissions$year)
     , ylab = "PM2.5 Emissions (in tonnes)"
     , xlab = "Year"
)
title("PM2.5 Emissions for Motor Vehicles in Baltimore City, MD by Year")
legend('topright'                                         # Add a position for the legend
       , legend = motorEmissions[,1]                # Add the legend Data
       , pch=19, col=seq(along.with = motorEmissions$year))             # Add Plotting Symbol, colors and scale factor

### Close the graphics device ###
dev.off()



