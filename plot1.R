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

# Create png device to write histogram to. set White background and 480 x 480 in size.
png("plot1.png", bg="transparent", width = 480, height =480)

## Draw the histogram of plot 1 in a png file
hist(datapw$Global_active_power, main="Global Active Power",
     xlab = "Global Active Power (kilowatts)", col="red")
# close the .png graphics device
dev.off()
