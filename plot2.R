# download data
url <-
  "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "exdata-data-household_power_consumption.zip", mode = "wb")
unlink(url)

# and extract file
unzip("exdata-data-household_power_consumption.zip")

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
with(
  data, plot(
    DateTime, Global_active_power, 
    xlab = "", ylab = "Global Active Power (kiloWatts)", 
    type = "l"
  )
)
with(data, lines(DateTime, Global_active_power))
dev.copy(png ,file = "plot2.png", width = 480, height = 480)
dev.off()
  