## The Project Data

This assignment uses data from the <a href="http://archive.ics.uci.edu/ml/">UC Irvine Machine Learning Repository</a>, a popular repository for machine learning datasets. In particular, we will be using the "Individual household electric power consumption Data Set" which I have made available onthe course web site:

* <b>Dataset</b>: <a href="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip">Electric power consumption</a> [20Mb]

* <b>Description</b>: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.


* The following descriptions of the 9 variables in the dataset are taken from the <a href="https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption">UCI
web site</a>:

<ol>
<li><b>Date</b>: Date in format dd/mm/yyyy </li>
<li><b>Time</b>: time in format hh:mm:ss </li>
<li><b>Global_active_power</b>: household global minute-averaged active power (in kilowatt) </li>
<li><b>Global_reactive_power</b>: household global minute-averaged reactive power (in kilowatt) </li>
<li><b>Voltage</b>: minute-averaged voltage (in volt) </li>
<li><b>Global_intensity</b>: household global minute-averaged current intensity (in ampere) </li>
<li><b>Sub_metering_1</b>: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered). </li>
<li><b>Sub_metering_2</b>: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light. </li>
<li><b>Sub_metering_3</b>: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.</li>
</ol>

## Data About the Data

Before loading the dataset into R, we were asked to consider the size of the dataset and whether we would have sufficient computer memory to load the whole file (certainly the simplest thing to do procedurely, using read.table). Here is the information we were given about the data.

* The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. Make sure your computer has enough memory (most modern computers should be fine).

* We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the data from just those dates rather than reading in the entire dataset and subsetting to those dates.

* Note that in this dataset missing values are coded as `?`.

A quick calculation showed that 2,075,259 rows x 9 columns x 8 bytes/element (assuming double precision real numbers) would result in **142.5 MiB**.  For safety, is usually a good idea to double that number; so we would be looking at **285 MiB**, which would fit easily in the 8 GB of RAM I have on my Mac.  However, just because you CAN do something, doesn't mean you SHOULD.

In this case, we are only interested in two days of data out of 4 years worth. Increasingly, in the real world, datasets are HUGE (often multiple TiB in size). When analytically searching for the proverbial "needle" in the "haystack", it is not practical to load the whole "haystack" into memory.  Therefore, even though I had plenty of memory on my Mac for this particular project, I decided it would be worthwhile to investigate the harder problem: Extracting only the data I needed and cleanng that up.

I chose to use a system call to "grep" to create a working dataset with just the two days of data we were interested in (2880 observations x 9 variables). It was stored in a file called **myPowerData.txt**.

## Cleaning the Data

I used a trick Roger Peng suggested to quickly characterize the data: I read in the first 10 rows from the working set and determined the format of the data, creating vector of the classes.  I then read in the full working set file setting the **colClasses** parameter of read.table equal to the classes vector. I also set the **na.strings** parameter to "?", per the instructions. I read the data into a dataframe called **powerData**. 

Most of the data was in the proper format.  However, the first two columns were read in as factors. They were going to require more work to support the graphs needed.

The x-axis of the majority of the plots were in a weird format, showing only the abbreviated day of the week for the data. Yet, there were thousands of data points plotted. That implied that the Date and Time columns would need to somehow be converted to POSIXlt/POSIXct format and combined.

I stripped out the Date column which was in **%d/%m/%Y** format and converted that a date vector using **as.Date()**.  The Time column was in an **%H:%M:%S** format. I stripped it out into separate column vector, converting it to a date vector using  **strptime()**. 

I then combined the two into a single vector called **DateTime**, first using the **paste()** function, then using the **ymd\_hms()** function from the **lubridate** package. That was then reformatted as a data frame and substituted in the **powerData** data frame, replacing the first two columns with one column.

The 8 resulting variables were then in the proper format, as evidenced by the summary command:

	> str(powerData)
	'data.frame':	2880 obs. of  8 variables:
	 $ DateTime             : POSIXct, format: "2007-02-01 00:00:00" "2007-02-01 00:01:00" "2007-02-01 00:02:00" ...
	 $ Global_active_power  : num  0.326 0.326 0.324 0.324 0.322 0.32 0.32 0.32 0.32 0.236 ...
	 $ Global_reactive_power: num  0.128 0.13 0.132 0.134 0.13 0.126 0.126 0.126 0.128 0 ...
	 $ Voltage              : num  243 243 244 244 243 ...
	 $ Global_intensity     : num  1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1 ...
	 $ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
	 $ Sub_metering_2       : num  0 0 0 0 0 0 0 0 0 0 ...
	 $ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...

A summary of the **powerData** data frame also provided useful insight into data ranges for plotting and to see if any data was missing:

	> summary(powerData)
	    DateTime                   Global_active_power Global_reactive_power    Voltage      Global_intensity Sub_metering_1    Sub_metering_2   Sub_metering_3  
	 Min.   :2007-02-01 00:00:00   Min.   :0.220       Min.   :0.0000        Min.   :233.1   Min.   : 1.000   Min.   : 0.0000   Min.   :0.0000   Min.   : 0.000  
	 1st Qu.:2007-02-01 11:59:45   1st Qu.:0.320       1st Qu.:0.0000        1st Qu.:238.4   1st Qu.: 1.400   1st Qu.: 0.0000   1st Qu.:0.0000   1st Qu.: 0.000  
	 Median :2007-02-01 23:59:30   Median :1.060       Median :0.1040        Median :240.6   Median : 4.600   Median : 0.0000   Median :0.0000   Median : 0.000  
	 Mean   :2007-02-01 23:59:30   Mean   :1.213       Mean   :0.1006        Mean   :240.4   Mean   : 5.102   Mean   : 0.4062   Mean   :0.2576   Mean   : 8.501  
	 3rd Qu.:2007-02-02 11:59:15   3rd Qu.:1.688       3rd Qu.:0.1440        3rd Qu.:242.4   3rd Qu.: 7.000   3rd Qu.: 0.0000   3rd Qu.:0.0000   3rd Qu.:17.000  
	 Max.   :2007-02-02 23:59:00   Max.   :7.482       Max.   :0.5000        Max.   :246.6   Max.   :32.000   Max.   :38.0000   Max.   :2.0000   Max.   :19.000

