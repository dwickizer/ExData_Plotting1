# 
# function plot2 (powerData)
#
# This function is passed dataframe called powerData and creates plot 2, which is a 
# 2-dimensional plot of date/time on the x-axis vs Global Active Power in kilowatts on the y-axis. 
# Only the abbreviated days of week are shown on the x-axis labels.
# 
# This graph is plotted to a file called plot2.png using the base plotting system.
#
# Dale Wickizer
# 10/7/2014

plot2 <- function (powerData) {
    
    # Graph Global Active Power vs Date & Time to plot2.png:
    
    # Open the file:
    png (filename = "./plot2.png")
    
    with (powerData, plot (DateTime, Global_active_power, type = "l", xlab = "", 
                         ylab = "Global Active Power (kilowatts)"))
    
    # Close the file   
    dev.off ()
}


