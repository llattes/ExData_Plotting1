plot3 <- function() {
  library(data.table)
  data <- fread("household_power_consumption.txt", 
                na.strings = c("NA", "N/A", "", NULL, "?"))
  data$Date <- as.Date(x = data$Date, format = "%d/%m/%Y")
  dateRange <- as.Date(x = c("2007-02-01", "2007-02-02"), format = "%Y-%m-%d")
  plottableData <- data[data$Date >= dateRange[1] &
                          data$Date <= dateRange[2], ]
  dateAndTime <- as.POSIXct(paste(as.character(plottableData$Date), plottableData$Time),
                            format="%Y-%m-%d %H:%M:%S")
  # Add the Date & Time combination as a column of the data.table.
  plottableData <- plottableData[, dateAndTime:=dateAndTime]

  # Create a plot without drawing anything...
  with(plottableData, plot(dateAndTime, Sub_metering_1, xlab = "",
                           ylab = "Energy sub metering", type = "n"))
  # And add one line at a time.
  with(plottableData, lines(dateAndTime, Sub_metering_1, col = "black"))
  with(plottableData, lines(dateAndTime, Sub_metering_2, col = "red"))
  with(plottableData, lines(dateAndTime, Sub_metering_3, col = "blue"))
  legend("top", col = c("black", "red", "blue"), lty = c(1, 1),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         bty = "n")
  dev.copy(png, file = "plot3.png")
  dev.off()
}
