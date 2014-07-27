# ########################################################################################################
# Plot 4
# Answers: The emissions from coal coal combustion sources in USA have decreased from 1999 to 2008. 
# However, there was a minor increase from 2002 to 2005.
# ########################################################################################################

### IMPORTANT :     PLEASE ENSURE THAT THE FILES summarySCC_PM25.rds AND Source_Classification_Code.rds 
###                            ARE IN THE SAME WORKING DIRECTORY

### Clear the workspace ###
rm(list = ls())

### Read the data from the files ###
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Find the index which has 'Combustion' in Level One field and 'coal' in Level.Four or Level.Three fields ###
combustionIndex <- grep("combustion", SCC$"SCC.Level.One", ignore.case=T)

coalIndex1 <- grep("coal", SCC$"SCC.Level.Three", ignore.case=T)
coalIndex2 <- grep("coal", SCC$"SCC.Level.Four", ignore.case=T)
coalIndex <- unique(c(coalIndex1,coalIndex2))
coalIndex <- sort(coalIndex)

### Find the Common Indices which have 'Combustion' in level.One field and 'Coal' in Level.Three or Level.Four field ###
coalCombustionIndex <- Reduce(intersect, list(combustionIndex,coalIndex))

### Find the coal combustion SCC values from the SCC data frame ###
SCCcoalCombustionSccs <- SCC[coalCombustionIndex,"SCC"]

### Find the corresponding index in the NEI data frame ###
NEICoalCombustionIndex <- (NEI$SCC %in% SCCcoalCombustionSccs)
sum(NEICoalCombustionIndex)
NEICoalCombustion <- NEI[NEICoalCombustionIndex, ]

### Aggregate the data ###
coalCombustionEmmisions <- aggregate(Emissions ~ year, NEICoalCombustion, sum)

###  Open the PNG graphics device ###
png(file="Plot4.png", width = 600, height = 600, units = "px")

### Plot the data using Base Plotting System ###
plot(coalCombustionEmmisions
     , type="o"
     , pch = 19
     , col = seq(along.with = coalCombustionEmmisions$year)
     , ylab = "PM2.5 Emissions (in tonnes)"
     , xlab = "Year"
)
title("PM2.5 Emissions for Coal Combustion Sources in USA by Year")
legend('topright'                                         # Add a position for the legend
       , legend = coalCombustionEmmisions[,1]                # Add the legend Data
       , pch=19, col=seq(along.with = coalCombustionEmmisions$year))             # Add Plotting Symbol, colors and scale factor


### Close the graphics device ###
dev.off()







