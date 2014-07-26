# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")

# Get SCCs of vehicle-related sources
vehicleSources <- SCC[grep("*Vehicle*", SCC$EI.Sector), ]
vehicleSources$SCC <- as.character(vehicleSources$SCC)

# Get emission data for vehicle-related sources in Baltimore
vehicleEmissions <- merge(NEI[NEI$fips == 24510 | NEI$fips == "06037", ],
                          vehicleSources)

# Reshape data
library(reshape2)
vehicleEmissions <- melt(vehicleEmissions,
                         id = c("year", "fips"), measure.vars = "Emissions")
annualVehicleEmissions <- dcast(vehicleEmissions,
                                year + fips ~ variable, sum)

# Plot graph
library(ggplot2)

png(filename = "plot6.png", width = 480, height = 480)

g <- ggplot(annualVehicleEmissions, aes(year, Emissions))

p <- g + geom_line(aes(color = fips)) + geom_point() +
     labs(title = "Total vehicle-related PM2.5 Emissions") +
     labs(x = "Year", y = "PM2.5 Emissions") +
     scale_colour_discrete("Source",
                           labels = c("Los Angeles County", "Baltimore City"))

print(p)

dev.off()