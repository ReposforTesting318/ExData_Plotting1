#Downloading and extracting data
if (!file.exists("household_power_consumption.txt")) {
  # Downloads the needed zipped files
  
  data_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  filename = "Electric power consumption.zip"
  download.file(data_url, filename)
  
  unzip(filename)
  
  
  file.remove(filename)
}

#Reads in data from file then subsets data for specified dates
power_data <- read.table("household_power_consumption.txt", header=TRUE, sep=';')

#Change types
power_data$Global_active_power <- sapply(power_data$Global_active_power, as.numeric)
power_data$dateTime = as.POSIXct(paste(power_data$Date, power_data$Time), format = "%d/%m/%Y %H:%M:%S")

# Filter Dates for 2007-02-01 and 2007-02-02
power_data <- subset(power_data, (dateTime >= "2007-02-01" & dateTime < "2007-02-03"))

#Create file
png("plot3.png", width=480, height=480)

#Write the plot into the file
plot(power_data[, dateTime], power_data[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power_data[, dateTime], power_data[, Sub_metering_2],col="red")
lines(power_data[, dateTime], power_data[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ", "Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), lwd=c(1,1))

dev.off()
