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

# plot histogram
windows()
with(
  data, hist(
    Global_active_power, main = "Global Active Power", col = "red" , xlab = "Global Active Power (kiloWatts)"
    )
)
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
  