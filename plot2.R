plot2 <- function () {
    NEI <- readNEI()
    emissionsByYear <- aggregate(Emissions ~ year, NEI[NEI$fips == "24510",], sum)
    
    png("plot2.png")
    barplot(emissionsByYear$Emissions, names.arg = emissionsByYear$year, 
            main = "Total PM2.5 Emissions in Baltimore City, Maryland",
            xlab = "Year", ylab = "PM2.5 Emissions (Tons)")
    dev.off()
}

readNEI <- function() {
    NEI <- readRDS("summarySCC_PM25.rds")
    
    NEI$fips <- factor(NEI$fips)
    NEI$SCC <- factor(NEI$SCC)
    NEI$Pollutant <- factor(NEI$Pollutant)
    NEI$type <- factor(NEI$type)
    NEI$year <- factor(NEI$year)
    
    NEI
}
