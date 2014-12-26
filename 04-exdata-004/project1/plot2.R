require(data.table)

# Read data from file
data <- fread("household_power_consumption.txt", 
              colClasses = "character", sep = ";")

# Limit data to entries from 2007-02-01 to 2007-02-02
subset <- subset(data, (Date == "1/2/2007" | Date == "2/2/2007"))

# Convert subset$Time to DateTime
subset$Time <- paste(subset$Date, subset$Time)
time <- strptime(subset$Time, format="%e/%m/%Y %H:%M:%S")
time <- as.POSIXct(time)
subset$Time <- time

# Convert subset$Global_active_power to numeric
subset$Global_active_power <- as.numeric(subset$Global_active_power)

# Plot Global Active Power and Dates
png(filename = "plot2.png", width = 480, height = 480)
plot(subset$Time, subset$Global_active_power, 
     type = "n", 
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(subset$Time, y = subset$Global_active_power)
dev.off()