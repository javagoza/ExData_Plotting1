# file: plot3.R

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


# plot graphs in png directly to avoid problems copying from screen
png("plot3.png", width=480, height=480)

with(data, plot(DateTime, Sub_metering_1,
    xlab = "", ylab = "Energy sub metering",
    type = "l", col="black"))

with(data, lines(DateTime, Sub_metering_2, col="red" ))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty = 1, col = c("black","red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2",  "Sub_metering_3"))

dev.off()
  