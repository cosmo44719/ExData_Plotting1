library(lubridate)

## download and unzip data if not already present
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("household_power_consumption.txt")) {
        download.file(fileURL,
                      method='curl', destfile='exdata-data-household_power_consumption.zip')
        unzip('exdata-data-household_power_consumption.zip')
}

## Read data
HPC <- read.table("household_power_consumption.txt", header=TRUE,
                  sep = ";", na.strings = "?",
                  colClasses = c(rep("character", 2), rep("numeric", 7)))

## merging date and time
HPC <- cbind(paste(HPC$Date, HPC$Time, sep = " "), HPC)
colnames(HPC)[1] <- "DateTime"

## convert Date and Time using lubridate package
HPC$Date <- dmy(HPC$Date)
HPC$Time <- hms(HPC$Time)
HPC$DateTime  <- dmy_hms(HPC$DateTime)

## subsetting data
HPC_subset <- subset(HPC, (year(Date) == 2007 & month(Date) == 2 &
                                   (day(Date) == 1 | day(Date) == 2)))

## plot2
png(filename="plot3.png")
plot(HPC_subset$DateTime, HPC_subset$Sub_metering_1, col="black", type="l",
     xlab = "", ylab = "Energy sub metering")
lines(HPC_subset$DateTime, HPC_subset$Sub_metering_2, col='red')
lines(HPC_subset$DateTime, HPC_subset$Sub_metering_3, col='blue')
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = "solid")
dev.off()
