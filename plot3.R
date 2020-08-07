## Loading packages:

# Tidyverse for dplyr, which is used for tibbles
# Upon retrospect, I didn't rely on dplyr-specific functions in this script, so you can do without.
# Lubridate is for easy parsing of the Date and Time columns in this script.
install.packages("tidyverse")
library(tidyverse)
install.package("lubridate")
library(lubridate)


## Check if file has already been downloaded and unzipped, if not -> do so
if (!file.exists("EPC.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "EPC.zip")
}

if (!file.exists("household_power_consumption.txt")) { 
  unzip("EPC.zip") 
}

#Reading dataset
EPC <- as_tibble(read.table("household_power_consumption.txt", header=T, sep=";"))

# Subsetting Feb 1st & 2nd 2007
EPC <- EPC[EPC$Date %in% c("1/2/2007","2/2/2007") ,]

#Global_active_power and subMetering1 to 3 are strings, needs to be converted to numeric
EPC$Global_active_power <- as.numeric(EPC$Global_active_power)
EPC$Sub_metering_1 <- as.numeric(EPC$Sub_metering_1)
EPC$Sub_metering_2 <- as.numeric(EPC$Sub_metering_2)
EPC$Sub_metering_3 <- as.numeric(EPC$Sub_metering_3)

#Creating datetime variable:
datetime <- parse_date_time(paste(EPC$Date, EPC$Time, sep=" "), "d m Y H M S")

#Creating the plot:
png("plot3.png")

plot(datetime, EPC$Sub_metering_1, type="l", ylab="Energy sub metering")
lines(datetime, EPC$Sub_metering_2, type="l", col="Red")
lines(datetime, EPC$Sub_metering_3, type="l", col="Blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

dev.off()