library(ggplot2)

# Load NEI data and factorize most columns
NEI <- readRDS("summarySCC_PM25.rds")
NEI$fips <- factor(NEI$fips)
NEI$SCC <- factor(NEI$SCC)
NEI$Pollutant <- factor(NEI$Pollutant)
# Define order for types, to control the faceted plot order
NEI$type <- factor(NEI$type, levels = c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD"))
NEI$year <- factor(NEI$year)

# Aggregate emissions by year and type
emissionsByYear <- aggregate(Emissions ~ year + type, NEI[NEI$fips == "24510",], sum)

# Generate faceted plot by type
png("plot3.png", height = 960)
p <- qplot(year, Emissions, data = emissionsByYear, facets = type ~ ., 
           geom = "bar", stat = "identity", 
           main = "Total PM2.5 Emissions by Type in Baltimore City, Maryland", 
           xlab = "Year", ylab = "PM2.5 Emissions (Tons)")
print(p)
dev.off()
