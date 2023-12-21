library(lubridate)
library(dplyr)

# Setting up the file path for reading the data set
file.path <- "/home/rstudio/Plotting Assingment/household_power_consumption.txt"

# Reading the data set
data <- read.table(file.path, header = TRUE, sep = ";", na.strings = "?")

# Converting the 'Date' and 'Time' column to date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- hms(data$Time)

# Filtering only dates, that will be used
filtered_dates <- as.Date(c("2007-02-01", "2007-02-02"))
data <- data[data$Date %in% filtered_dates, ]

# Combining Date and Time Columns into the new column DateTime
final_data <- mutate(data, DateTime = as_datetime(data$Date) + as.duration(data$Time))

############# Plot 4 #############
##################################

png("plot4.png", width = 480, height = 480, units = "px")

par(mfrow=c(2,2))	
  
plot(final_data$DateTime, final_data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(final_data$DateTime, final_data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(final_data$DateTime, final_data$Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering")
    lines(final_data$DateTime, final_data$Sub_metering_2, type="l", col="red")
    lines(final_data$DateTime, final_data$Sub_metering_3, type="l", col="blue")
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(final_data$DateTime, final_data$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()