# Of the four types of sources indicated by the type
# (point, nonpoint, onroad, nonroad) variable, which of these four sources have
# seen decreases in emissions from 1999–2008 for Baltimore City? Which have
# seen increases in emissions from 1999–2008?
#
# Use the ggplot2 plotting system to make a plot answer this question.

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

library(reshape2)

BaltimoreEmissions <- melt(NEI[NEI$fips == 24510, ],
                           id = c("year", "type"), measure.vars = "Emissions")
typeBaltimoreEmissions <- dcast(BaltimoreEmissions, year + type ~ variable, sum)

typeBaltimoreEmissions$type <- as.factor(typeBaltimoreEmissions$type)

library(ggplot2)

png(filename = "plot3.png", width = 480, height = 480)

g <- ggplot(typeBaltimoreEmissions, aes(year, Emissions))

p <- g + geom_smooth(aes(color = type)) +
     labs(title = "PM2.5 Emissions in Baltimore City by source") +
     labs(x = "Year", y = "PM2.5 Emissions") +
     scale_colour_discrete("Source")

print(p)

dev.off()