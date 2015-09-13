###Exploratory Data Analysis Course Project 1

###Plot2.R

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

###Plot
plot(filtered_hpc$Date, filtered_hpc$Global_active_power, type="l", 
     main="", xlab = "", ylab="Global Active Power (kilowatts)",
     cex.axis=0.8, cex.lab=0.8, cex.main=0.9)

###Copy plot to a PNG file
dev.copy(png, file="./plot2.png", width=480, height=480)
dev.off()