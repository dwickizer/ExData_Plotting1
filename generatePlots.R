# 
# generatePlots ()
#
# Calls 5 functions, in this order:
#
#   readData ():        Extracts the portion of data we are interested in from the file 
#                       "./household_power_consumption.txt" and creates a small working file called 
#                       myPowerData.txt. That function also cleans the data, putting it the proper 
#                       format and returns a data frame called **powerData** for use in the plotting 
#                       functions
#
#   plot1 (powerData):  Plots a histogram of Global Active Power (kilowatts) on the x-axis vs
#                       frequency (y-axis) to a bitmap file called "plot1.png"
#
#   plot2 (powerData):  Plots a 2-dimensional graph of Global Active Data (y-axis) vs Date & Time, 
#                       expressed as abbreviated days of the week (x-axis) both to a bitmap file 
#                       called "plot2.png"
#
#   plot3 (powerData):  Plots a 2-dimensional graph of Energy sub metering (y-axis) vs Data & Time,
#                       expressed as abbreviated days of the week (x-axis) to a bitmap file called 
#                       "plot3.png"
#
#   plot4 (powerData):  Plots a 2 x 2 grid of four 2-dimensional plots of date/time on the x-axis vs 
#                       Global Active Power (upper left), Energy sub metering (lower left), 
#                       Voltage (upper right), and Global Reactive Power (lower right) on the y-axes.
#                       The graphs are saved to a bitmap file called "plot4.png"
#
#
# Dale Wickizer
# 10/8/2014

generatePlots <- function () {
    
    source("readData.R")
    source("plot1.R")
    source("plot2.R")
    source("plot3.R")
    source("plot4.R")
    
    powerData <- readData ()
    
    plot1 (powerData)
    
    plot2 (powerData)
    
    plot3 (powerData)
    
    plot4 (powerData)
    
}

