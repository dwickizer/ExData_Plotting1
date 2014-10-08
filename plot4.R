# 
# function plot4 (powerData)
#
# This function is passed dataframe called powerData and creates plot 4, which is a 
# a 2 x 2 grid of four 2-dimensional plots of date/time on the x-axis vs 
# Global Active Power (upper left), Energy sub metering (lower left), Voltage (upper right), and
# Global Reactive Power (lower right) on the y-axes.
# 
# Only the abbreviated days of week are shown on the x-axis labels.
# 
# This graph is plotted to a file called plot4.png using the base plotting system.
#
# Dale Wickizer
# 10/8/2014

plot4 <- function (powerData) {
    
    # Graph  file plot4.png:
    
    # Open the file:
    png (filename = "./plot4.png")
    
    # Set parameter for 2 x 2 grid of 4 plots
    par (mfcol = c (2,2))
    
    with (powerData, {
        
        # Upper left: Global Active Power vs Data & Time
        plot (DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
        
        # Lower left: Energy Sub Metering vs Data & Time
        # Start with the Sub_metering_1 data, which has the largest range
        plot (DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        
        # Next add the Sub_metering_2 data, but change it to red
        lines  (DateTime, Sub_metering_2, type = "l", col = "red")
        
        # Then add the Sub_metering_3 data, but change it to blue
        lines (DateTime, Sub_metering_3, type = "l", col = "blue")
        
        # Lastly, add the legend to the upper right corner of the graph
        legend ("topright", lty = 1, seg.len = 3, col = c("black", "red", "blue"), 
                legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                box.lty = 0, cex = 0.8)
        
        # Upper right: Voltage vs Data & Time
        plot (DateTime, Voltage, type = "l")
        
        # Lower right: Global Reactive Power vs Data & Time
        plot (DateTime, Global_reactive_power, type = "l")
        
    })
    
    # Close file
    dev.off ()
}