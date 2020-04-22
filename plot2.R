plot2<-function() {
        
# Set up library, working directory
library(graphics)
library(grDevices)
library(dplyr)
if(!dir.exists("~/jhu_coursera"))
{dir.create("~/jhu_coursera")}
setwd("~/jhu_coursera")

## Load saved subsutted data if exists
if(file.exists("~/jhu_coursera/feb.txt")) {
feb<-read.table("~/jhu_coursera/feb.txt",header=T,stringsAsFactors=F)
feb$Date<-as.Date(feb$Date,"%Y-%m-%d") }

## Download, unzip data
if(!file.exists("~/jhu_coursera/feb.txt")) { 
        url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        
        download.file(url, destfile = "~/jhu_coursera/epc.zip", method="curl")
        
        unzip("~/jhu_coursera/epc.zip", exdir="~/jhu_coursera")
        
        ## Read file, subset Feb 1-2, 2007 only
        epc<-read.csv("~/jhu_coursera/household_power_consumption.txt",header=T,sep=";",
        stringsAsFactors=F,na.strings="?")
        
        epc$Date<-as.Date(epc$Date,"%d/%m/%Y")
        feb<-filter(epc, Date=="2007-02-01" | Date=="2007-02-02")

        ## Save subset data to wd
        write.table(feb,file="feb.txt",na="NA") }

## Adjust columns
feb$Time<-strptime(paste(feb$Date,feb$Time),"%F %T") 

## Create plot of global active power vs time
with(feb, plot(Time, Global_active_power, type="l", xlab=NA, 
               ylab="Global Active Power (kilowatts)"))

## Copy plot to  png file, close device
dev.copy(png,file="plot2.png",width = 480, height = 480)
dev.off()
message("plot2.png saved to working directory")
}
