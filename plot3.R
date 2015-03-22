library(ggplot2)

plot3 <- function () {
    NEI <- readNEI()
    emissionsByYear <- aggregate(Emissions ~ year + type, NEI[NEI$fips == "24510",], sum)
    
    png("plot3.png", height = 960)
    qplot(year, Emissions, data = emissionsByYear, facets = type ~ ., geom = "bar", stat = "identity", 
          main = "Total PM2.5 Emissions by Type in Baltimore City, Maryland", 
          xlab = "Year", ylab = "PM2.5 Emissions (Tons)")
    dev.off()
}

readNEI <- function() {
    NEI <- readRDS("summarySCC_PM25.rds")
    
    NEI$fips <- factor(NEI$fips)
    NEI$SCC <- factor(NEI$SCC)
    NEI$Pollutant <- factor(NEI$Pollutant)
    NEI$type <- factor(NEI$type, levels = c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD"))
    NEI$year <- factor(NEI$year)
    
    NEI
}
