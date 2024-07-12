# Load data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Convert to Date/Time classes
datetime <- strptime(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")
subset_data$DateTime <- datetime
#----^^^^ THIS IS THE SAME AS THE OTHER PLOTS^^^^ ----

# Plot 4: Multiple Plots
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Top-left plot
plot(subset_data$DateTime, subset_data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Top-right plot
plot(subset_data$DateTime, subset_data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Bottom-left plot
plot(subset_data$DateTime, subset_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subset_data$DateTime, subset_data$Sub_metering_2, col="red")
lines(subset_data$DateTime, subset_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, bty="n")

# Bottom-right plot
plot(subset_data$DateTime, subset_data$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")

dev.off()
