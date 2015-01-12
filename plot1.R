plot1 <- function() {
  library(data.table)
  data <- fread("household_power_consumption.txt", 
                na.strings = c("NA", "N/A", "", NULL, "?"))
  data$Date <- as.Date(x = data$Date, format = "%d/%m/%Y")
  dateRange <- as.Date(x = c("2007-02-01", "2007-02-02"), format = "%Y-%m-%d")
  plottableData <- data[data$Date >= dateRange[1] &
                          data$Date <= dateRange[2], ]
  hist(as.numeric(plottableData$Global_active_power),
       main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
       col = "red")
  dev.copy(png, file = "plot1.png")
  dev.off()
}
