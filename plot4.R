# Load NEI data and factorize most columns
NEI <- readRDS("summarySCC_PM25.rds")
NEI$fips <- factor(NEI$fips)
NEI$SCC <- factor(NEI$SCC)
NEI$Pollutant <- factor(NEI$Pollutant)
NEI$type <- factor(NEI$type)
NEI$year <- factor(NEI$year)

# Load SCC data
SCC <- readRDS("Source_Classification_Code.rds")

# Get SCC codes for coal combustion sources. I viewed the results to confirm the correct content.
# This excludes other forms of combustion, and other coal-related sources like mining.
coalRows <- which(apply(SCC, 1, function(x) any(grepl("coal", x, ignore.case = TRUE))))
combustionRows <- which(apply(SCC, 1, function(x) any(grepl("comb", x, ignore.case = TRUE))))
# Although the word "charcoal" contains "coal", it is not from coal sources
nonCharcoalRows <- which(!apply(SCC, 1, function(x) any(grepl("charcoal", x, ignore.case = TRUE))))
sccCodes <- SCC$SCC[intersect(intersect(coalRows, nonCharcoalRows), combustionRows)]

# Aggregate emissions by year
emissionsByYear <- aggregate(Emissions ~ year, NEI[NEI$SCC %in% sccCodes,], sum)

# Show emissions in megatons
emissions <- emissionsByYear$Emissions / 1e6

# Generate simple bar chart
png("plot4.png")
barplot(emissions, names.arg = emissionsByYear$year, 
        main = "Coal Combustion-Related PM2.5 Emissions in the United States",
        xlab = "Year", ylab = "PM2.5 Emissions (Megatons)")
dev.off()
