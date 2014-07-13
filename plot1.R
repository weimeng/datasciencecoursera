require(data.table)

# Read data from file
data <- fread("household_power_consumption.txt", 
              colClasses = "character", sep = ";")

# Limit data to entries from 2007-02-01 to 2007-02-02
subset <- subset(data, (Date == "1/2/2007" | Date == "2/2/2007"))

# Plot Global Active Power
png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(subset$Global_active_power), 
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")
dev.off()