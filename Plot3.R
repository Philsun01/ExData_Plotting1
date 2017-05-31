### checks subset of electricity usage
### already exists so waste time reloading data
if(!exists("usage")) {
  
  ### if subset data does not exist,     
  ### import data and tidy it up
  usage <- read.table("household_power_consumption.txt",
                      skip = 66636,
                      nrows = 2880,
                      sep = ";",
                      header = TRUE, 
                      stringsAsFactors = FALSE,
                      colClasses = c("character","character",rep("numeric",7))
  )
  
  ### Retrieving column names since original dataframe
  ### did not load names from skipping rows
  col_names <- names( read.table("household_power_consumption.txt",
                                 header = TRUE, 
                                 sep= ";", 
                                 nrows = 1))
  ### Applying new column names
  names(usage) <- col_names
  remove(col_names)
  ### Combining date and time 
  ### then converting to POSIXlt
  usage$Date_Time <- strptime(
    paste(usage$Date,usage$Time), 
    "%d/%m/%Y %H:%M:%S")
  return(usage)
}



### Setup for a single plot
dev.new()
par(mfrow=c(1,1),mar = c(3,6,3,3))
##############  Plotting Graph ##########
plot(
  usage$Date_Time,
  usage$Sub_metering_1, 
  type = "l",
  xlab = "",
  ylab = "Energy sub metering"
)
lines(usage$Date_Time,usage$Sub_metering_2, col = "red")
lines(usage$Date_Time,usage$Sub_metering_3, col = "blue")

legend(x = "topright",
       lty = 1,
       cex = .6,
       pt.cex = 2,
       legend = c("Sub Metering 1","Sub Metering 2","Sub Metering 3"),
       col = c("black","red","blue"),
       bty = "o"
       )

print("Plot 3 Chart Loaded")