NEI <- readRDS("./data/summarySCC_PM25.rds")
dataCodes <- readRDS("./data/Source_Classification_Code.rds")
head(dataCodes)

#Plot 1
#find total emissions for each year
sum_by_year <- aggregate(NEI$Emissions, by=list(year=NEI$year), FUN=sum)

#plot total emissions for all four years
png(filename = "plot1.png")
plot(sum_by_year$year, sum_by_year$x, type = "l",
     main = "Total Emissions of PM2.5 in the United States",
     xlab = "Year",
     ylab = "Total Emissions of PM2.5 (tons)")
dev.off()