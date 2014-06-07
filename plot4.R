# Coursera Exploratory Data Analysis - Project 1

# Read in the data, put date in separate columns, combine
inputdata<-read.table("household_power_consumption.txt", header=TRUE, sep=";",na.strings="?")
inputdatadate<-strsplit(as.character(inputdata$Date),"/")
inputdatadate2<-matrix(unlist(inputdatadate),ncol=3,byrow=TRUE)
day<-as.numeric(inputdatadate2[,1])
month<-as.numeric(inputdatadate2[,2])
year<-as.numeric(inputdatadate2[,3])
time<-inputdata$Time

inputdataclean<-cbind(day,month,year,inputdata[,2:9])

rm(inputdatadate,inputdatadate2,day,month,year,time)

# subset the data
inputdataclean1<-subset(inputdataclean,year==2007 & month==2)
inputdataclean3<-subset(inputdataclean1,day<3)

# convert to dates
dates<-paste(inputdataclean3$month,"/",inputdataclean3$day,"/",inputdataclean3$year," ",inputdataclean3$Time,sep="")
dates2<-strptime(dates,"%m/%d/%Y %H:%M:%S")
rm(dates)

# Plot 4

png(filename="plot4.png", width=480,height=480,units="px")
# combine plots using par
op<-par(mfcol=c(2,2))  # mfcol fills by column

# subplotA
plot(dates2,as.numeric(inputdataclean3[,"Global_active_power"]),type="l",xlab="",ylab="Global Active Power")

# subplotB
plot(dates2,as.numeric(inputdataclean3[,"Sub_metering_1"]),type="l",xlab="",ylab="Energy sub metering",ylim=c(0,38))
lines(dates2,as.numeric(inputdataclean3[,"Sub_metering_2"]),type="l",xlab="",ylab="",col="red",ylim=c(0,38))
lines(dates2,as.numeric(inputdataclean3[,"Sub_metering_3"]),type="l",xlab="",ylab="",col="blue",ylim=c(0,38))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black","red","blue"),lty=1,lwd=1,box.lty=0)

# subplotC
plot(dates2,as.numeric(inputdataclean3[,"Voltage"]),type="l",xlab="datetime",ylab="Voltage")

# subplotD
plot(dates2,as.numeric(inputdataclean3[,"Global_reactive_power"]),type="l",xlab="datetime",ylab="Global_reactive_power")
range(as.numeric(inputdataclean3[,"Global_reactive_power"]))

par(op)
dev.off()
