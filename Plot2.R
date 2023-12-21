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

############# Plot 2 #############
##################################

png("plot2.png", width = 480, height = 480, units = "px")

plot(final_data$Global_active_power ~ final_data$DateTime, data, type = "l",
     ylab = "Global Active Power (kilowatts)",
     xlab = NA)

dev.off()






