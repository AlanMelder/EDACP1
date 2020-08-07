## Loading packages:

# Tidyverse for dplyr, which is used for tibbles
# Upon retrospect, I didn't rely on dplyr-specific functions in this script, so you can do without.
install.packages("tidyverse")
library(tidyverse)



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

#Global_active_power is a string, needs to be converted to numeric
EPC$Global_active_power <- as.numeric(EPC$Global_active_power)

#Creating the plot:
png("plot1.png")

hist(EPC$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="Red")

dev.off()