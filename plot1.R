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
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")

# Filter Dates for 2007-02-01 and 2007-02-02
power_data <- subset(power_data, (Date >= "2007-02-01" & Date <= "2007-02-02"))

#Create file
png("plot1.png", width=480, height=480)

#Write the plot into the file
hist(power_data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
