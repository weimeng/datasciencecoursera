# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a
# plot answering this question.

NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")

library(reshape2)

BaltimoreEmissions <- melt(NEI[NEI$fips == 24510, ],
                           id = "year", measure.vars = "Emissions")
annualBaltimoreEmissions <- dcast(BaltimoreEmissions, year ~ variable, sum)

png(filename = "plot2.png", width = 480, height = 480)

barplot(annualBaltimoreEmissions$Emissions,
        names.arg = annualBaltimoreEmissions$year,
        main = "Baltimore City, Maryland PM2.5 emissions from 1999 to 2008",
        xlab = "Year",
        ylab = "PM2.5 emissions")

dev.off()