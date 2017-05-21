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
data1$Global_active_power <- as.numeric(as.character(data1$Global_active_power))
data1$Global_reactive_power <- as.numeric(as.character(data1$Global_reactive_power))
data1$Voltage <- as.numeric(as.character(data1$Voltage))

#Open the png
png("plot4.png") #default height and width are as specified in the notes

#Set up the mfrow and the margins
par(mfrow=c(2,2),mar=c(4,4,2,2))

#Plot
with(data1, {
  plot(DateTime,Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type="n")
  lines(DateTime,Global_active_power)
})

with(data1, {
  plot(DateTime,Voltage,ylab="Voltage",xlab="datetime",type="n")
  lines(DateTime,Voltage)
})

with(data1,{
  plot(DateTime,Sub_metering_1,ylab="Energy sub metering",xlab="",type="n")
  lines(DateTime,Sub_metering_1,col="black")
  lines(DateTime,Sub_metering_2,col="red")
  lines(DateTime,Sub_metering_3,col="blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))
})

with(data1, {
  plot(DateTime,Global_reactive_power,ylab="Global_active_power",xlab="datetime",type="n")
  lines(DateTime,Global_reactive_power)
})

#Close the file
dev.off()