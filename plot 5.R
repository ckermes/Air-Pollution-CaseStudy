NEI <- readRDS("./data/summarySCC_PM25.rds")
dataCodes <- readRDS("./data/Source_Classification_Code.rds")
head(dataCodes)

#Question: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#merged data to get emissions and motor vehicle in same sheet
mergedData <- merge(NEI, dataCodes, by = "SCC")

#subset to just baltimore city 
bmore <- mergedData[mergedData$fips == 24510,]

#subset baltimore city to type == motor vehicle 
bmorecars <- bmore[bmore$Data.Category == 'Onroad',]

#sum bmorecars by year
bmore_cars_year <- aggregate(bmorecars$Emissions, by=list(bmorecars$year), FUN = sum)
colnames(bmore_cars_year) <- c("year", "emissions")

#graph motor vehicle by year
library(ggplot2)
png(filename = "plot5.png")
qplot(year, emissions, data = bmore_cars_year, geom = "line", color = 'red') +  #Group.2 is year. x is emissions. Group.1 is Type
        ggtitle("Total Car Emissions per Year in Baltimore") +
        ylab("Total Emissions (tons)") +
        xlab("Year")
dev.off()
