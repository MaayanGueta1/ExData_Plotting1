data<- read.table ("household_power_consumption.txt", header = TRUE, sep = ";")

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
subset_data <- data[data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02"), ]
subset_data$Global_active_power <- as.numeric(subset_data$Global_active_power)


# Open PNG graphics device with specified width and height
png("plot1.png", width = 480, height = 480)


hist(subset_data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")


# Close the PNG graphics device
dev.off()
