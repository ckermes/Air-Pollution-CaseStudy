NEI <- readRDS("./data/summarySCC_PM25.rds")
dataCodes <- readRDS("./data/Source_Classification_Code.rds")
head(dataCodes)

#subset into just data for Baltimore through fips=="24510"
bmore <- NEI[NEI$fips == 24510,]
#sum based on year
sum_by_year <- aggregate(bmore$Emissions, by=list(year=bmore$year), FUN=sum)

#graph
png(filename = "plot2.png")
plot(sum_by_year$year, sum_by_year$x, type = "l",
     main = "Total Emissions of PM2.5 in Baltimore",
     xlab = "Year",
     ylab = "Total Emissions of PM2.5 (tons)")
dev.off()