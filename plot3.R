plot3<-function() {
        
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
        
## Create plot of submetering vs time
plot(feb$Time,feb$Sub_metering_1,type="n", xlab=NA, ylab="Energy sub metering")
lines(feb$Time,feb$Sub_metering_1,type="l", col="black")
lines(feb$Time,feb$Sub_metering_2,type="l", col="red")
lines(feb$Time,feb$Sub_metering_3,type="l", col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
col=c("black","red","blue"),lty=1,cex=.9)
        
## Copy plot to  png file, close device
dev.copy(png,file="plot3.png",width = 480, height = 480)
dev.off()
message("plot3.png saved to working directory")
}
