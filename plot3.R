data<- read.table ("household_power_consumption.txt", header = TRUE, sep = ";")

# Convert Date and Time columns to POSIXct class
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Subset the data for 2007-02-01 to 2007-02-02
subset_data <- data[data$DateTime >= as.POSIXct("2007-02-01 00:00:00") & 
                      data$DateTime <= as.POSIXct("2007-02-02 23:59:59"), ]

# Calculate time elapsed since the beginning of 2007-02-01
subset_data$Time_elapsed <- difftime(subset_data$DateTime, as.POSIXct("2007-02-01 00:00:00"), units = "hours")

png("plot3.png", width = 480, height = 480)


par(mar = c(4,7,4,7))


# Plot the line chart with suppressed x-axis and adjusted margin

plot(subset_data$Time_elapsed, subset_data$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering", xaxt = "n")

# Add lines for Sub_metering_2 and Sub_metering_3
lines(subset_data$Time_elapsed, subset_data$Sub_metering_2, col = "red")
lines(subset_data$Time_elapsed, subset_data$Sub_metering_3, col = "blue")

# Customize legend with straight horizontal line symbol
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

# Customize x-axis labels if needed
x_ticks <- c(0, 24, 48)  # Positions for Thu, Fri, and Sat
x_labels <- c("Thu", "Fri", "Sat")  # Labels for the ticks
axis(1, at = x_ticks, labels = x_labels)

dev.off()
