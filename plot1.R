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

#save subsetted data in txt format
#save(HPC_subset, file = "HPC_subset.txt")

## plot1
png(filename="plot1.png")
hist(HPC_subset$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()