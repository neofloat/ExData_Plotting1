#read in the header of the table
cnames = colnames(read.table("household_power_consumption.txt",
                             nrow = 1, header = TRUE, sep=";"))
#read the 2 days data, and assign the header name to this table
datapw <- read.table('household_power_consumption.txt', col.names=cnames, header = T,
                     sep = ';', stringsAsFactors = F, na.strings = '?', skip = 66636, nrow = 2880,
                     colClasses=c("character", "character",rep("numeric",7)))
#Transforming Date/time data
datapw$DateTime <- strptime(paste(datapw$Date, datapw$Time),
                            "%d/%m/%Y  %H:%M:%S")

# Create png device to write to. set White background and 480 x 480 in size.
png("plot4.png", bg="transparant", width=480,height=480)
#Multiple plot
par(mfrow = c (2,2))
#Graphic top left
with(datapw,plot(DateTime,Global_active_power, type="l",xlab="",ylab="Global Active Power"))
#Graphic top right
with(datapw,plot(DateTime,Voltage, type="l",xlab="datetime",ylab="Voltage"))
#Graphic bottom left
plot(datapw$DateTime,datapw$Sub_metering_1,xlab="",ylab="Energy sub metering",type="n")
with(datapw, lines(DateTime, Sub_metering_1, col = "black"))
with(datapw, lines(DateTime, Sub_metering_2, col = "red"))
with(datapw, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright",bty="n", lty=c(1,1,1),col=c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#Graphic bottom right"
with(datapw,plot(DateTime,Global_reactive_power, type="l",xlab="datetime"))
# close the .png graphics device
dev.off()
