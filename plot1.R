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
hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

           