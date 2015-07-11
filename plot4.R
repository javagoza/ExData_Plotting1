# file: plot4.R

# get dates in english
Sys.setlocale("LC_TIME", "English")

# download data if not downloaded before
if(!file.exists("household_power_consumption.txt")){
  url <-
    "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, destfile = "exdata-data-household_power_consumption.zip", mode = "wb")
  unlink(url)
  
  # and extract file
  unzip("exdata-data-household_power_consumption.zip")
}


fullData <-
  read.csv(
    "household_power_consumption.txt", sep = ";", header = TRUE,
    na.strings = "?",  stringsAsFactors = FALSE
  )

# fiter data required
data<-fullData[which( fullData$Date == "2/2/2007" | fullData$Date == "1/2/2007"),]

# fee space
rm(fullData)

# create date time column and copy date time
data$DateTime <-
  strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")

# plot graphs
windows()

par(mfrow = c(2,2))

# Plot Global Active Power
with(
  data, plot(
    DateTime, Global_active_power, 
    xlab = "", ylab = "Global Active Power", 
    type = "l"
  )
)

# Plot Voltage
with(
  data, plot(
    DateTime, Voltage, 
    xlab = "datetime", ylab = "Voltage", 
    type = "l"
  )
)

# Plot Sub metering
with(data, plot(DateTime, Sub_metering_1,
    xlab = "", ylab = "Energy sub metering",
    type = "l", col="black"))

with(data, lines(DateTime, Sub_metering_2, col="red" ))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", bty ="n", cex =1 , lty = 1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2",  "Sub_metering_3"))

# Plot Global_Reactive_Power
with(
  data, plot(
    DateTime, Global_reactive_power, 
    xlab = "datetime", ylab = "Global_Reactive_Power", 
    type = "l"
  )
)

dev.copy(png ,file = "plot4.png", width = 480, height = 480)
dev.off()
  