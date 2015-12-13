plot2 <- function(){
    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
    "
    temp <- tempfile()
    download.file(fileUrl,temp,mode="wb")
    wrkfile <- unzip(temp)
    unlink(temp)
    
    library(sqldf)

    # Data file is read - omitting all observations except those for 2007-2-1 and 2007-2-2
    dt <- read.csv.sql(wrkfile, header = TRUE, sep = ";", sql = "select * from 
               file where Date = '1/2/2007' or Date = '2/2/2007' ")
    
    # Date and Time columns are combined, converted, and added to dataframe and original Date & Time columns removed
    dt$DateTime <- as.POSIXct(paste(dt$Date,dt$Time), format="%d/%m/%Y %H:%M:%S")
    dt$Date <- NULL
    dt$Time <- NULL
    
    #Open png file device to create file with result of plot
    png(filename = "plot2.png", width=480, height=480)
    
    # Create line graph
    plot(dt$DateTime,dt$Global_active_power, type="l", 
         ylab = "Global Active Power (kilowatts)", xlab="" )
    
    # Close png file device
    dev.off()
}
