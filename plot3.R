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

png("plot3.png", bg="transparant", width = 480, height =480)
par(mar = c(3,4,2,1))
plot(datapw$DateTime,datapw$Sub_metering_1,ylab="Energy sub metering",type="n")
with(datapw, lines(DateTime, Sub_metering_1, col = "black"))
with(datapw, lines(DateTime, Sub_metering_2, col = "red"))
with(datapw, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# close the .png graphics device
dev.off()
