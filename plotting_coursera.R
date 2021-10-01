library(stringr)

energy_data <- read.table("/Users/rileybrenner/Downloads/household_power_consumption.txt", header = T,sep = ";")

energy_subset <- energy_data[66637:69516,]

hist(as.numeric(energy_subset$Global_active_power), col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")

energy_subset$Time <- strptime(paste(energy_subset$Date, " ", energy_subset$Time), format = "%d/%m/%Y %H:%M:%S")

energy_subset$Date <- as.Date(energy_subset$Date, format = "%d/%m/%Y")

plot(x = energy_subset$Time, y = energy_subset$Global_active_power, "l", xlab = " ", ylab = "Global Active Power (kilowatts)")

plot(x = energy_subset$Time, y = energy_subset$Sub_metering_1, "l", ylab = "Energy sub metering", xlab = " ")
lines(x = energy_subset$Time, y = energy_subset$Sub_metering_2, col = "red")
lines(x = energy_subset$Time, y = energy_subset$Sub_metering_3, col = "blue")
legend("topright" , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red", "blue"), lty = 1, box.lty=0)

par(mfrow=c(2,2))
plot(x = energy_subset$Time, y = energy_subset$Global_active_power, "l", xlab = " ", ylab = "Global Active Power (kilowatts)")
plot(x = energy_subset$Time, y = energy_subset$Voltage, "l", xlab = "datetime", ylab = "Voltage")

plot(x = energy_subset$Time, y = energy_subset$Sub_metering_1, "l", ylab = "Energy sub metering", xlab = " ")
lines(x = energy_subset$Time, y = energy_subset$Sub_metering_2, col = "red")
lines(x = energy_subset$Time, y = energy_subset$Sub_metering_3, col = "blue")
legend("topright"  , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black","red", "blue"), lty = 1, box.lty=0, cex =0.6)

plot(x = energy_subset$Time, y = energy_subset$Global_reactive_power, "l", xlab = "datetime", ylab = "Global_reactive_power")


