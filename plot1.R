plot1<-function() {
        
# Set up library, working directory
library(graphics)
library(grDevices)
library(dplyr)
if(!dir.exists("~/jhu_coursera"))
{dir.create("~/jhu_coursera")}
setwd("~/jhu_coursera")

## Download, unzip data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, destfile = "~/jhu_coursera/epc.zip", method="curl")

unzip("~/jhu_coursera/epc.zip", exdir="~/jhu_coursera")

## Read file, subset Feb 1-2, 2007 only
epc<-read.csv("~/jhu_coursera/household_power_consumption.txt",header=T,sep=";",
              stringsAsFactors=F,na.strings="?")

epc$Date<-as.Date(epc$Date,"%d/%m/%Y")
feb<-filter(epc, Date=="2007-02-01" | Date=="2007-02-02")

## Save subset data to wd
write.table(feb,file="feb.txt",na="NA") 

feb$Time<-strptime(paste(feb$Date,feb$Time),"%F %T") 

## Create histogram of Global active power
hist(feb$Global_active_power, col="red", 
  xlab="Global Active Power (kilowatts)", main="Global Active Power")

## Copy plot to  png file, close device
dev.copy(png,file="plot1.png",width = 480, height = 480)
dev.off()
message("plot1.png saved to working directory")
}
