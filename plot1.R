# Have total emissions from PM2.5 decreased in the United States from 1999 to
# 2008? Using the base plotting system, make a plot showing the total PM2.5
# emission from all sources for each of the years 1999, 2002, 2005, and 2008.

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

library(reshape2)

annualEmissions <- melt(NEI, id = "year", measure.vars = "Emissions")

# Divide sum of emissions by 1,000,000 to make Y label more readable
annualTotalEmissions <- dcast(annualEmissions, year ~ variable,
                              function(x) sum(x) / 1000000)

png(filename = "plot1.png", width = 480, height = 480)

barplot(annualTotalEmissions$Emissions,
        names.arg = annualTotalEmissions$year,
        main = "Total PM2.5 emissions from 1999 to 2008",
        xlab = "Year",
        ylab = "PM2.5 emissions in millions")

dev.off()