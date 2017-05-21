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
data1$Sub_metering_1 <- as.numeric(as.character(data1$Sub_metering_1))
data1$Sub_metering_2 <- as.numeric(as.character(data1$Sub_metering_2))
data1$Sub_metering_3 <- as.numeric(as.character(data1$Sub_metering_3))

#Open the png
png("plot3.png") #default height and width are as specified in the notes

#Plot
with(data1, plot(DateTime,Sub_metering_1,ylab="Energy sub metering",xlab="",type="n"))
with(data1,lines(DateTime,Sub_metering_1,col="black"))
with(data1,lines(DateTime,Sub_metering_2,col="red"))
with(data1,lines(DateTime,Sub_metering_3,col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))

#Close the file
dev.off()