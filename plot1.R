plot1 <- function() {
  require("data.table")
  data <- fread("household_power_consumption.txt", 
                na.strings = c("NA", "N/A", "", NULL, "?"))
  data$Date <- as.Date(x = data$Date, format = "%d/%m/%Y")
  dateRange <- as.Date(x = c("2007-02-01", "2007-02-02"), format = "%Y-%m-%d")
  # Subset the data to keep only the needed dates.
  plottableData <- data[data$Date >= dateRange[1] &
                          data$Date <= dateRange[2], ]
  # Draw a red histogram with the given main title and x-label.
  png(filename = "plot1.png", width = 480, height = 480,
      units = "px")
  hist(as.numeric(plottableData$Global_active_power),
       main = "Global Active Power", xlab = "Global Active Power (kilowatts)",
       col = "red")
  dev.off()
}
