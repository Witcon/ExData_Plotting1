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
plot(data$Date, data$Global_active_power,
     ylab = "Global Active Power (kilowatts)", xlab = "", type = "l")
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()