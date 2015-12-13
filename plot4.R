plot4 <- function(){
    
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
    "
    temp <- tempfile()
    download.file(fileUrl,temp,mode="wb")
    wrkfile <- unzip(temp)
    unlink(temp)
    
    
    library(sqldf)

    # Read data file - omitting all observations except those for 2007-2-1 and 2007-2-2
    dt <- read.csv.sql(wrkfile, header = TRUE, sep = ";", sql = "select * from 
               file where Date = '1/2/2007' or Date = '2/2/2007' ")
    
    # Date and Time columns are combined, converted, and added to dataframe and original Date & Time columns removed
    dt$DateTime <- as.POSIXct(paste(dt$Date,dt$Time), format="%d/%m/%Y %H:%M:%S")
    dt$Date <- NULL
    dt$Time <- NULL
    
    #Open png file device to create file with result of plot
    png(filename = "plot4.png", width=480, height=480)
    
    #Setup for multiple base plots
    par(mfrow=c(2,2))
    
    # Create plotA
    plot(dt$DateTime,dt$Global_active_power, type="l", 
         ylab = "Global Active Power", xlab="" )
    
    # Create plotB
    plot(dt$DateTime,dt$Voltage, type="l", 
         ylab = "Voltage", xlab="datetime" )
    
    # Create plotC
    with(dt, plot(DateTime, Sub_metering_1,type = "n", ylab="Energy sub metering",xlab=""))
    with(dt, points(DateTime, Sub_metering_1, type="l", col="black"))
    with(dt, points(DateTime, Sub_metering_2, type="l", col="red"))
    with(dt, points(DateTime, Sub_metering_3, type="l", col="blue"))
    legend("topright",lty=1, col=c("black", "red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n", cex=0.9)
    
    # Create plotD
    plot(dt$DateTime,dt$Global_reactive_power, type="l", 
         ylab = "Global_reactive_power", xlab="datetime" )
    
    
    # Close png file device
    dev.off()
}
