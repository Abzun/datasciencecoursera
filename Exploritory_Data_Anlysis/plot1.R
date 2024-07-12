# Load data
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
subset_data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

# Convert to Date/Time classes
datetime <- strptime(paste(subset_data$Date, subset_data$Time), format="%Y-%m-%d %H:%M:%S")
subset_data$DateTime <- datetime

# Plot 1: Global Active Power
png("plot1.png", width=480, height=480)
plot(subset_data$DateTime, subset_data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
