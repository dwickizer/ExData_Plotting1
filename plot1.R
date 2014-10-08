# 
# function plot1 (powerData)
#
# This function creates plot 1, which is a histogram of Global Active Power in kilowatts vs frequency
# This graph is plotted to a file called plot1.png using the base plotting system.
#
# Dale Wickizer
# 10/7/2014

plot1 <- function (powerData) {
    # Graph Global Active Power to plot1.png:
    
    # Open the file:
    png  (filename = "./plot1.png")
    
    hist (powerData$Global_active_power, col = "red", main = "Global Active Power", 
         xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
    
    # Close the file:
    dev.off ()
    
    
}
