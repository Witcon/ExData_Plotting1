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
png(file = "plot3.png")
plot(data$Date, data$Sub_metering_1, ylab = "Energy sub metering", 
     xlab = "", type = "l")
lines(data$Date, data$Sub_metering_2, col = 2)
lines(data$Date, data$Sub_metering_3, col = 4)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
                              "Sub_metering_3"), pt.cex = 1,
                               col = c(1,2,4),lty = 1)
dev.off()