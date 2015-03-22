# Load NEI data and factorize most columns
NEI <- readRDS("summarySCC_PM25.rds")
NEI$fips <- factor(NEI$fips)
NEI$SCC <- factor(NEI$SCC)
NEI$Pollutant <- factor(NEI$Pollutant)
NEI$type <- factor(NEI$type)
NEI$year <- factor(NEI$year)

# Aggregate emissions by year
emissionsByYear <- aggregate(Emissions ~ year, NEI, sum)

# Show emissions in megatons
Emissions <- emissionsByYear$Emissions / 1e6

# Generate simple bar chart
png("plot1.png")
barplot(Emissions, names.arg = emissionsByYear$year, 
        main = "Total PM2.5 Emissions in the United States",
        xlab = "Year", ylab = "PM2.5 Emissions (Megatons)")
dev.off()
