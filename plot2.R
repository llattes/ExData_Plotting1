plot2 <- function() {
  library(data.table)
  data <- fread("household_power_consumption.txt", 
                na.strings = c("NA", "N/A", "", NULL, "?"))
  data$Date <- as.Date(x = data$Date, format = "%d/%m/%Y")
  dateRange <- as.Date(x = c("2007-02-01", "2007-02-02"), format = "%Y-%m-%d")
  plottableData <- data[data$Date >= dateRange[1] &
                          data$Date <= dateRange[2], ]
  dateAndTime <- as.POSIXct(paste(as.character(plottableData$Date), plottableData$Time),
                            format="%Y-%m-%d %H:%M:%S")
  plot(x = dateAndTime, y = as.numeric(plottableData$Global_active_power),
       xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
  dev.copy(png, file = "plot2.png")
  dev.off()
}
