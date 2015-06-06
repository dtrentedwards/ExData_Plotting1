## Exploratory Data Analysis Class Project 1
## Read data
library(data.table)
library(lubridate)
data <- fread("household_power_consumption.txt")


## Change variables to Date class where format = Y-M-D
data$Date <- dmy(data$Date)
dt <- data[Date %between% c("2007-01-31", "2007-02-02")]
datetime <- paste(dt$Date, dt$Time)
datetime <- strptime(datetime, format = "%Y-%m-%d %H:%M:%S", tz = "")
dt <- cbind(dt, datetime)

##  Convert columns into correct class
dt$Global_active_power <- as.numeric(dt$Global_active_power)
dt$Global_reactive_power <- as.numeric(dt$Global_reactive_power)
dt$Voltage <- as.numeric(dt$Voltage)
dt$Global_intensity <- as.numeric(dt$Global_intensity)
dt$Sub_metering_1 <- as.numeric(dt$Sub_metering_1)
dt$Sub_metering_2 <- as.numeric(dt$Sub_metering_2)
dt$Sub_metering_3 <- as.numeric(dt$Sub_metering_3)

##  Plot4.png
png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
plot(dt$datetime, dt$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(dt$datetime, dt$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
plot(dt$datetime, dt$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dt$datetime, dt$Sub_metering_2, col = "red")
lines(dt$datetime, dt$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, col = c("black", "red", "blue"), bty = "n", merge = TRUE)
plot(dt$datetime, dt$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()