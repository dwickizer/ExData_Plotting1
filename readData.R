
# function readData()
#
# Reads in and processes data from ./household_power_consumption.txt file using 
# For two days, 2/1/2007 and 2/2/2007, and returns a data frame (called powerData 
# within the function).
# 
# This assumes the underlying operating system is Unix
#
# See CodeBook.md for specifics on file and data frame formats
#
# Dale Wickizer
# 10/7/2014
#
#
readData <- function() {
    
    library(lubridate)
    
    dataFile <- "./household_power_consumption.txt"
    
    if (file.exists(dataFile)) {
        
        # characterize the data to support faster reading and proper format (Courtesy of Roger Peng)
        initial <- read.table(dataFile, header=TRUE, sep = ";", na.strings = "?", nrows = 10)
        classes <- sapply(initial, class)
        
        # Grab the header line and save it to a working fine called myPowerData.txt
        system("head -n 1 ./household_power_consumption.txt > myPowerData.txt")
            
        # Grab the dates of interest for this project and add those to the working file
        system("grep ^[12]/2/2007 ./household_power_consumption.txt >> myPowerData.txt")
        
        # Read the working file into a table and return the dataframe.
        powerData <- read.table("./myPowerData.txt", header=TRUE, sep = ";", na.strings ="?", 
                                colClasses = classes)
        
        # All the plots (but the first one) require that Date and Time be combined. These are 
        # currently factors and are going to need to be converted to the proper formats. We want 
        # abbreviated weekdays and time.
        
        # Let's get the weekdays
        pDate <- as.character(as.Date(powerData$Date, format = "%d/%m/%Y"))
        
        # Let's get the time
        pTime <- format(strptime(powerData$Time, format = "%H:%M:%S"), "%H:%M:%S")
        
        # Combine, element by element
        DateTime <- paste(pDate,pTime)
        
        # Change to "POSIXct" "POSIXt" date and time
        DateTime <- ymd_hms(DateTime, tz = "")
        
        # Make it a dataframe
        DateTime <- data.frame(DateTime)
        
        # Replace the first two columns of powerData with this one colume
        powerData <- cbind(DateTime, powerData[,3:9])
        
        
        return(powerData)
        
    }
    else {
        stop("Input file ./household_power_consumption.txt data file not found.")
    }
}