# file: plot3.R

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
  read.table(
    "household_power_consumption.txt", sep = ";", header = TRUE, na.strings =
      "?",  stringsAsFactors = FALSE
  )

# create date time column
fullData$DateTime <-
  strptime(paste(fullData$Date,fullData$Time), "%d/%m/%Y %H:%M:%S")

# filter data between "2007-02-01" and "2007-02-02"
data <-
  fullData[which((fullData$DateTime >= "2007-02-01") &
                   (fullData$DateTime < "2007-02-03")),]
# fee space
rm(fullData)

# get names in english
Sys.setlocale("LC_TIME", "English")

# plot histogram
windows()
with(data, plot(DateTime, Sub_metering_1,
    xlab = "", ylab = "Energy sub metering",
    type = "l", col="black"))

with(data, lines(DateTime, Sub_metering_2, col="red" ))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty = 1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2",  "Sub_metering_3"))

dev.copy(png ,file = "plot3.png", width = 480, height = 480)
dev.off()
  