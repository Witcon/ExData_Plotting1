if (!file.exists("tidy_household_power_consumption.txt")) {
  rawData <- file("household_power_consumption.txt", "r")
  cat(grep("(^Date)|(^[1|2]/2/2007)",readLines(rawData), value=TRUE), 
      sep="\n", file="tidy_household_power_consumption.txt")
  close(rawData)
}
data <- read.table("tidy_household_power_consumption.txt", sep = ";", 
                   na.strings = "?", header = TRUE,
                   colClasses = c("character", "character", rep("numeric", 7))
)
data$Date <- paste(data[,1], data[,2], sep=" ") 
data$Time <- NULL 
data[,1] <- as.POSIXct(data[,1], format = "%d/%m/%Y %H:%M:%S")
png(file = "plot4.png")
par(mfrow = c(2, 2))
plot(data$Date, data$Global_active_power,
     ylab = "Global Active Power", xlab = "", type = "l")
plot(data$Date, data$Voltage,
     ylab = "Voltage", xlab = "datetime", type = "l")
plot(data$Date, data$Sub_metering_1, ylab = "Energy sub metering", 
     xlab = "", type = "l")
lines(data$Date, data$Sub_metering_2, col = 2)
lines(data$Date, data$Sub_metering_3, col = 4)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"), cex = 0.8, col = c(1,2,4),
                               bty = "n", lty = 1)
plot(data$Date, data$Global_reactive_power,
     ylab = "Global_reactive_power", xlab = "datetime", type = "l")
dev.off()