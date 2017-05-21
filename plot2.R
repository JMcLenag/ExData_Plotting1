library(dplyr)

#Download the file and unzip in the working directory
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"Week1Data.zip")
unzip("Week1Data.zip",exdir = "Week1Data")

#Read in the file
data <- read.table("Week1Data/household_power_consumption.txt",sep=";",header=T)

#Set up the dates
data$Date <- as.Date(data$Date,"%d/%m/%Y")

#Filter to just the required dates
data1 <- filter(data,Date=="2007-02-01"| Date=="2007-02-02")

#Set up a datetime column
data1$DateTime <- strptime(paste(data1$Date,data1$Time),"%Y-%m-%d %H:%M:%S")

#Set up the variable to plot as a numeric
data1$Global_active_power <- as.numeric(as.character(data1$Global_active_power))

#Open the png
png("plot2.png") #default height and width are as specified in the notes

#Plot
with(data1, plot(DateTime,Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type="n"))
with(data1,lines(DateTime,Global_active_power))

#Close the file
dev.off()