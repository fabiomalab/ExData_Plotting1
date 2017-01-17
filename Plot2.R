## This works if in the current directory, the file
## "household_power_consumption.txt" can be found


## Required packages
## library(chron)
library(dplyr)


## reading the file. Only the first 70K lines are read
hhpc <- read.delim("household_power_consumption.txt", na.strings="?", dec=".",
                   nrow= 70000, header=TRUE, sep=";", as.is=TRUE)

## Adding a new column with date and time.
## Type is set to POSIXct
hhpc <- mutate(hhpc, DayHour = paste(Date, Time))
hhpc$DayHour <- as.POSIXct(strptime(hhpc$DayHour,  "%d/%m/%Y %T", tz=""))

## Subsetting the first 2 days of February
hhpc$Date <- as.Date(hhpc$Date, "%d/%m/%Y")
feb3 <- as.Date("03/02/07", "%d/%m/%y")
jan31 <- as.Date("31/01/07", "%d/%m/%y")
hhpc <- filter(hhpc, Date<feb3 & Date>jan31)

## 2nd plot

png(filename="plot2.png")
plot(hhpc$DayHour, hhpc$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

