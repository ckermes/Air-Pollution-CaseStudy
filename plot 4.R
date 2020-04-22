NEI <- readRDS("./data/summarySCC_PM25.rds")
dataCodes <- readRDS("./data/Source_Classification_Code.rds")
head(dataCodes)

#Question: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#combine dataCodes and NEI data to get combustion related devices and emissions on same sheet 
mergedData <- merge(NEI, dataCodes, by = "SCC")
#fetch all records for coal and merge into one data frame
coalCombust <- grep("Coal", mergedData$EI.Sector)
coal <- mergedData[coalCombust,]
#sum up coal emissions by year 
coal_emissions_year <- aggregate(coal$Emissions, by=list(coal$year), FUN = sum)
colnames(coal_emissions_year) <- c("year", "emissions")
#graph combustion vs year 
library(ggplot2)
png(filename = "plot4.png")
qplot(year, emissions, data = coal_emissions_year, geom = "line", color = 'red') +  #Group.2 is year. x is emissions. Group.1 is Type
        ggtitle("Total Emissions of Coal Combustion Sources") +
        ylab("Total Emissions (tons)") +
        xlab("Year")
dev.off()