###Exploratory Data Analysis Course Project 1

###Plot4.R

###Set working directory to the location where the ExData_Plotting1 Dataset was unzipped
setwd('~/Google Drive/mooc/DataScienceSpecialization/ExploratoryDataAnalysis/ExData_Plotting1/');

###Read the data between 1/02/2007 and 02/02/2007
###Using read.csv2.sql from sqldf package for subseting
###OS independent
###Median elapsed time 17sec
library(sqldf)

###Start the clock!
#ptm <- proc.time()

#filtered_hpc <- read.csv.sql("./household_power_consumption.txt", sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'", header=TRUE, sep=';')

###Stop the clock
#proc.time() - ptm

###Another option for Unix/Linux/Mac users
###Using grep to subset file before read.table
###But first, whe have to read the file's first line to get the column names
###Median elapsed time 3sec

###Start the clock!
#ptm <- proc.time()

df.row1 <- read.table("./household_power_consumption.txt", header = TRUE, nrow = 1, sep = ";", comment.char = "", stringsAsFactors = FALSE)
filtered_hpc <- read.table(pipe('grep "^[1-2]/2/2007" "./household_power_consumption.txt"'), header = FALSE, sep = ";", comment.char = "", stringsAsFactors = FALSE)
names(filtered_hpc) <- names(df.row1)

###Stop the clock
#proc.time() - ptm

###Convert the Date and Time variables to Date/Time classes
###First, paste Date and Time in the Date column
filtered_hpc$Date <- paste(filtered_hpc$Date, filtered_hpc$Time)

###Remove the Time column
filtered_hpc[c("Time")] <- list(NULL)

###Convert chr Date to POSIXlt
filtered_hpc$Date <- strptime(filtered_hpc$Date, "%d/%m/%Y %H:%M:%S")

###Configure the number of plots in the graphic device
###Set the graphic device hold 4 diferent plots
par(mfrow = c(2, 2))

###Set the margins
par("mar" = c(4, 4, 3, 3))

###Plot1
plot(filtered_hpc$Date, filtered_hpc$Global_active_power, type="l", 
     main="", xlab = "", ylab="Global Active Power",
     cex.axis=0.8, cex.lab=0.8, cex.main=0.9)

###Plot2
plot(filtered_hpc$Date, filtered_hpc$Voltage, type="l", 
     main="", xlab = "datetime", ylab="Voltage",
     cex.axis=0.8, cex.lab=0.8, cex.main=0.9)

###Plot3
plot(filtered_hpc$Date, filtered_hpc$Sub_metering_1, type="n", 
     main="", xlab = "", ylab="Energy sub metering ",
     cex.axis=0.8, cex.lab=0.8, cex.main=0.9)
lines(filtered_hpc$Date, filtered_hpc$Sub_metering_1, type="l", col="black")
lines(filtered_hpc$Date, filtered_hpc$Sub_metering_2, type="l", col="red")
lines(filtered_hpc$Date, filtered_hpc$Sub_metering_3, type="l", col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, col=c("black", "red", "blue"), cex=0.70, seg.len=2, y.intersp=0.8, bty="n")

###Plot4
plot(filtered_hpc$Date, filtered_hpc$Global_reactive_power, type="l", 
     main="", xlab = "datetime", ylab="Global_reactive_power",
     cex.axis=0.8, cex.lab=0.8, cex.main=0.9)

###Copy plot to a PNG file
dev.copy(png, file="./plot4.png", width=480, height=480)
dev.off()