## plot1.r script
## by Guillaume LE MENER

## IMPORTANT - the script assumes that the data source file is in the working directorty!
## and the file name is 'household_power_consumption.txt'

## IMPORTANT - I decided not using the 'sqldf' package since there is a strong dependency on Mac OSX that forces to install X11 libraries...

## loading some packages
##if(!require("sqldf")) {
##        install.packages("sqldf")
##        library("sqldf")
##}

## Read the data from the working directory
data_file <- paste(getwd(),"/household_power_consumption.txt", sep="")

if (file.exists(data_file)) {
        data <- read.csv2(data_file, stringsAsFactors=FALSE, colClasses=c(rep("character",2), rep("numeric",7)), dec=".", na.strings=c("?",""), strip.white=TRUE)
        } else {
        stop(paste("File missing: ", data_file))        
}

## Date and Time conversion in one new column
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

## Arranging columns - last columns DateTime becomes first and drop the previous Date and Time
data <- data[, c(10,3:9)]

## Subsetting - ONLY 2 days 2007-02-01 and 2007-02-02
data <- data[data$DateTime >= as.POSIXct("2007-02-01") & data$DateTime < as.POSIXct("2007-02-03"),]

## Open the PNG devices with 480x480 pixels in size
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

## Histograme for Plot1
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

## Closing the device
dev.off()

