data<- read.table ("household_power_consumption.txt", header = TRUE, sep = ";")

# Convert Date and Time columns to POSIXct class
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Subset the data for 2007-02-01 to 2007-02-02
subset_data <- data[data$DateTime >= as.POSIXct("2007-02-01 00:00:00") & 
                      data$DateTime <= as.POSIXct("2007-02-02 23:59:59"), ]

# Calculate time elapsed since the beginning of 2007-02-01
subset_data$Time_elapsed <- difftime(subset_data$DateTime, as.POSIXct("2007-02-01 00:00:00"), units = "hours")

png("plot4.png", width = 480, height = 480)


par(mfrow=c(2,2), mar = c(4,4,1,3))

#plot1
plot(subset_data$Time_elapsed, subset_data$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power", xaxt = "n")
# Define the positions and labels for the x-axis ticks
x_ticks <- c(0, 24, 48)  # Positions for Thu, Fri, and Sat
x_labels <- c("Thu", "Fri", "Sat")  # Labels for the ticks

# Customize x-axis labels
axis(1, at = x_ticks, labels = x_labels)

#plot2
plot(subset_data$Time_elapsed, subset_data$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage",xaxt = "n" )


# Define the positions and labels for the x-axis ticks
x_ticks <- c(0, 24, 48)  # Positions for Thu, Fri, and Sat
x_labels <- c("Thu", "Fri", "Sat")  # Labels for the ticks

# Customize x-axis labels
axis(1, at = x_ticks, labels = x_labels)

#plot3
plot(subset_data$Time_elapsed, subset_data$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering", xaxt = "n")

# Add lines for Sub_metering_2 and Sub_metering_3
lines(subset_data$Time_elapsed, subset_data$Sub_metering_2, col = "red")
lines(subset_data$Time_elapsed, subset_data$Sub_metering_3, col = "blue")

# Customize legend with straight horizontal line symbol
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1,  text.font = 0.5, x.intersp = 1,y.intersp = 1.0, bty = "n")

# Customize x-axis labels if needed
x_ticks <- c(0, 24, 48)  # Positions for Thu, Fri, and Sat
x_labels <- c("Thu", "Fri", "Sat")  # Labels for the ticks
axis(1, at = x_ticks, labels = x_labels)

#plot4
plot(subset_data$Time_elapsed, subset_data$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power",xaxt = "n" )


# Define the positions and labels for the x-axis ticks
x_ticks <- c(0, 24, 48)  # Positions for Thu, Fri, and Sat
x_labels <- c("Thu", "Fri", "Sat")  # Labels for the ticks

# Customize x-axis labels
axis(1, at = x_ticks, labels = x_labels)


dev.off()

