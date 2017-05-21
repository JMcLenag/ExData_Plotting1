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

#Set up the variable to plot as a numeric
data1$Global_active_power <- as.numeric(as.character(data1$Global_active_power))

#Open the png
png("plot1.png") #default height and width are as specified in the notes

#Plot
with(data1, hist(Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red"))

#Close the file
dev.off()
