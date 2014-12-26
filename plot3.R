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

# Convert Sub_metering_x to numeric
subset$Sub_metering_1 <- as.numeric(subset$Sub_metering_1)
subset$Sub_metering_2 <- as.numeric(subset$Sub_metering_2)
subset$Sub_metering_3 <- as.numeric(subset$Sub_metering_3)

# Set graphics file
png(filename = "plot3.png", height = 480, width = 480)

# Initialize plot
plot(subset$Time, subset$Sub_metering_1, 
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")

# Add lines
lines(subset$Time, subset$Sub_metering_1)
lines(subset$Time, subset$Sub_metering_2, col = "red")
lines(subset$Time, subset$Sub_metering_3, col = "blue")

# Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1)

# Close graphics file
dev.off()