NEI <- readRDS("./data/summarySCC_PM25.rds")
dataCodes <- readRDS("./data/Source_Classification_Code.rds")
head(dataCodes)

#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

#subset bmore data into 4 types, and by each year
bmore <- NEI[NEI$fips == 24510,]
typeyear <- aggregate(bmore$Emissions, by=list(bmore$type, bmore$year), FUN = sum)

#plot of four different graphs, one for each type, through ggplot nrow = 4
library(ggplot2)
png(filename = "plot3.png")
qplot(Group.2, x, data = typeyear, color = Group.1, geom = "line") +  #Group.2 is year. x is emissions. Group.1 is Type
        ggtitle("Total Emissions of PM2.5 in Baltimore City by Pollutant Type") +
        ylab("Total Emissions (tons)") +
        xlab("Year")
dev.off()