# 
# function plot3 (powerData)
#
# This function is passed dataframe called powerData and creates plot 3, which is a 
# 2-dimensional plot of date/time on the x-axis vs submetering data on the y-axis. 
# Only the abbreviated days of week are shown on the x-axis labels.
# 
# This graph is plotted to a file called plot3.png using the base plotting system.
#
# Dale Wickizer
# 10/8/2014

plot3 <- function (powerData) {
    
    # Graph Energy sub metering vs Date & Time file plot3.png:
    
    # Open the file:
    png (filename = "./plot3.png")
    
    with (powerData, {
        
        # Start with the Sub_metering_1 data, which has the largest range
        plot (DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        
        # Next add the Sub_metering_2 data, but change it to red
        lines  (DateTime, Sub_metering_2, type = "l", col = "red")
        
        # Then add the Sub_metering_3 data, but change it to blue
        lines (DateTime, Sub_metering_3, type = "l", col = "blue")
        
        # Lastly, add the legend to the upper right corner of the graph
        legend ("topright", lty = 1, seg.len = 3, col = c("black", "red", "blue"), 
                legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    })
    
    
    
    # Close file
    dev.off ()
}