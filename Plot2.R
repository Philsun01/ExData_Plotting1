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

### Close previous Plot
dev.off() 
### Setup for a single plot
dev.new()
par(mfrow=c(1,1),mar = c(3,6,3,3))

##############  Plotting Graph ##########
plot(
  usage$Date_Time,
  usage$Global_active_power, 
  xlab = "",
  ylab = "Global Active Power (kilowatts)",
  type = "l"
  )

print("Plot 2 Chart Loaded")