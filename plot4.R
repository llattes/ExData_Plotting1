plot4 <- function() {
  library(data.table)
  data <- fread("household_power_consumption.txt", 
                na.strings = c("NA", "N/A", "", NULL, "?"))
  data$Date <- as.Date(x = data$Date, format = "%d/%m/%Y")
  dateRange <- as.Date(x = c("2007-02-01", "2007-02-02"), format = "%Y-%m-%d")
  plottableData <- data[data$Date >= dateRange[1] &
                          data$Date <= dateRange[2], ]
  dateAndTime <- as.POSIXct(paste(as.character(plottableData$Date), plottableData$Time),
                            format="%Y-%m-%d %H:%M:%S")
  plottableData <- plottableData[, dateAndTime:=dateAndTime]

  # Setup the 2 by 2 canvas.  
  par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
  # Row 1, Col 1 graph.
  plot(x = dateAndTime, y = as.numeric(plottableData$Global_active_power),
       xlab = "", ylab = "Global Active Power", type = "l")
  # Row 1, Col 2 graph.
  plot(x = dateAndTime, y = as.numeric(plottableData$Voltage),
       xlab = "datetime", ylab = "Voltage", type = "l")
  # Row 2, Col 1 graph.
  with(plottableData, plot(dateAndTime, Sub_metering_1, xlab = "",
                           ylab = "Energy sub metering", type = "n"))
  with(plottableData, lines(dateAndTime, Sub_metering_1, col = "black"))
  with(plottableData, lines(dateAndTime, Sub_metering_2, col = "red"))
  with(plottableData, lines(dateAndTime, Sub_metering_3, col = "blue"))
  legend("top", col = c("black", "red", "blue"), lty = c(1, 1),
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         cex = 0.75, bty = "n")
  
  # Row 2, Col 2 graph.
  plot(x = dateAndTime, y = as.numeric(plottableData$Global_reactive_power),
       xlab = "datetime", ylab = "Global_reactive_power", type = "l")
  
  dev.copy(png, file = "plot4.png")
  dev.off()
}
