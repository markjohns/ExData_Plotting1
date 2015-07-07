##plot1.R

## the file with the data should be unzipped and placed in the working directory
## please install the following packages
##lubridate
library(lubridate)
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

##the first plot is a histogram of Global Active Power
##code to display the plot on the computer screen
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")


##open png device
png(file = "plot1.png")
##code to create the plot that will be placed in the png file
hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
##close the png file device
dev.off()



