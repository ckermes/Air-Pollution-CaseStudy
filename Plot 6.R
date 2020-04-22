NEI <- readRDS("./data/summarySCC_PM25.rds")
dataCodes <- readRDS("./data/Source_Classification_Code.rds")
head(dataCodes)

#Question: compare motor vehicle emissions in baltimore to those in la (fip = 06037) over 1999-2008

#merged data to get emissions and motor vehicle in same sheet
mergedData <- merge(NEI, dataCodes, by = "SCC")

#subset to la and bmore
baltLa_cars <- subset(mergedData, mergedData$fips=="24510" |
                              mergedData$fips=="06037" &
                              mergedData$type=="ON-ROAD")

baltLa_Car_year <- aggregate(baltLa_cars$Emissions, by=list(baltLa_cars$fips, baltLa_cars$year),
                             FUN=sum)
colnames(baltLa_Car_year) <- c('city', 'year', 'emissions')

#create plot 
library(ggplot2)
png(filename = "plot6.png")
qplot(year, emissions, data = baltLa_Car_year, geom = "line", color = city) +  #Group.2 is year. x is emissions. Group.1 is Type
        ggtitle("Total Car Emissions by year in Baltimore and LA") +
        ylab("Total Emissions (tons)") +
        xlab("Year")
dev.off()