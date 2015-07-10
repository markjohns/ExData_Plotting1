##plot4.R
ls()
rm(list=ls())
## the file with the data should be unzipped and placed in the working directory
## please install the following packages
##lubridate
##dplyr
library(lubridate)
library(dplyr)
##read the file
## determine the first and last row to be read
first_day <- "1/2/2007"
last_day_plus_one <- "3/2/2007"
start_row <- grep(first_day,readLines("./household_power_consumption.txt"))[1]
start_row
end_row <- grep(last_day_plus_one,readLines("./household_power_consumption.txt"))[1]
end_row
##skip all rows before the row that conatains "1/2/2007"
##read a number of rows equal to end row - start_row
##there are ? in the data to indicate missing values; these will be shown as NA
##Date and Time are read as characters rather than as factors
data <- read.table("./household_power_consumption.txt",skip=start_row-1,nrows=end_row-start_row,sep = ";", colClasses = c("character","character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric"), stringsAsFactors = FALSE, na.strings = "?")
head(data)
tail(data)
class_of_data <- lapply(data, class)
class_of_data
##add header with column names
##read tha names form the dataset
data_header_names <- read.table("./household_power_consumption.txt",nrows=1,sep = ";", header=TRUE)
head(data_header_names)
##copy the names into data
names(data) <- names(data_header_names)
head(data)

##check if any value in this range is the character ?
##grep("\\?", data, value=TRUE)
print("check if there are ? characters; the result should be named character(0)")
grep("\\?",data, value=TRUE)


##check the class of the data
class_of_data <- lapply(data, class)
class_of_data
##read date
head(data$Date)

##the plot in the top left is the same as the second plot (plot2.png) taht is a plot of Global Active Power (kilowatts) by day of the week
##the plot in the top right is a plot of voltage by day of the week
##the plot in the bottom left is the sane as the the third plot (plot3.png) that is a plot of Energy Sub Metering by day of the week
##the plot in the bottom right is plot of Global_reactive_power by day of the week


##create a new column with data and time and add it to data
data_with_date_time <- mutate(data, Date_time = paste(data$Date, data$Time))
head(data_with_date_time)

##prepare vector with Date_time in US formatted version
date_time_formatted <- dmy_hms(data_with_date_time$Date_time)
head(date_time_formatted)

## change the column with Date_time in US formatted version
data_with_date_time <- mutate(data, Date_time = date_time_formatted)
head(data_with_date_time)


##prepare the area for inserting the four plots
par(mfrow = c(2, 2))

##the plot in the top left is the same as the second plot (plot2.png) that is a plot of Global Active Power (kilowatts) by day of the week except (kilowatts) is not included
plot(data_with_date_time$Date_time, data_with_date_time$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l", pch = 3, lwd =1)

##the plot in the top right is a plot of voltage by day of the week
plot(data_with_date_time$Date_time, data_with_date_time$Voltage, ylab = "Voltage", xlab = "datetime", type = "l", pch = 3, lwd =1)


##the plot in the bottom left is the sane as the the third plot (plot3.png) that is a plot of Energy Sub Metering by day of the week; there is no box around the legend, though
plot(data_with_date_time$Date_time, data_with_date_time$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n", pch = 3, lwd =1, col = "black")
lines(data_with_date_time$Date_time, data_with_date_time$Sub_metering_1, ylab = "Energy Sub Metering", xlab = "", type = "l", pch = 3, lwd =1, col = "black")
lines(data_with_date_time$Date_time, data_with_date_time$Sub_metering_2, ylab = "Energy Sub Metering", xlab = "", type = "l", pch = 3, lwd =1, col = "red")
lines(data_with_date_time$Date_time, data_with_date_time$Sub_metering_3, ylab = "Energy Sub Metering", xlab = "", type = "l", pch = 3, lwd =1, col = "blue")
legend("topright", lty = 1, lwd =1, bty ="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.6)


##the plot in the bottom right is plot of Global_reactive_power by day of the week
plot(data_with_date_time$Date_time, data_with_date_time$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l", pch = 3, lwd =1)



##open png device
png(file = "plot4.png")
##code to create the plot that will be placed in the png file
par(mfrow = c(2, 2))

##the plot in the top left is the same as the second plot (plot2.png) that is a plot of Global Active Power (kilowatts) by day of the week except (kilowatts) is not included
plot(data_with_date_time$Date_time, data_with_date_time$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l", pch = 3, lwd =1)

##the plot in the top right is a plot of voltage by day of the week
plot(data_with_date_time$Date_time, data_with_date_time$Voltage, ylab = "Voltage", xlab = "datetime", type = "l", pch = 3, lwd =1)


##the plot in the bottom left is the sane as the the third plot (plot3.png) that is a plot of Energy Sub Metering by day of the week; there is no box around the legend, though
plot(data_with_date_time$Date_time, data_with_date_time$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n", pch = 3, lwd =1, col = "black")
lines(data_with_date_time$Date_time, data_with_date_time$Sub_metering_1, ylab = "Energy Sub Metering", xlab = "", type = "l", pch = 3, lwd =1, col = "black")
lines(data_with_date_time$Date_time, data_with_date_time$Sub_metering_2, ylab = "Energy Sub Metering", xlab = "", type = "l", pch = 3, lwd =1, col = "red")
lines(data_with_date_time$Date_time, data_with_date_time$Sub_metering_3, ylab = "Energy Sub Metering", xlab = "", type = "l", pch = 3, lwd =1, col = "blue")
legend("topright", lty = 1, lwd =1, bty ="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.6)


##the plot in the bottom right is plot of Global_reactive_power by day of the week
plot(data_with_date_time$Date_time, data_with_date_time$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l", pch = 3, lwd =1)

##close the png file device
dev.off()


