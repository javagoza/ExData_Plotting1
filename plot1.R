# plot1.R
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
  fullData$DateTime <- paste(fullData$Date, fullData$Time)
  # create date time column
  fullData$DateTime <-
    as.Date(fullData$DateTime, format = "%d/%m/%Y %H:%M:%S")
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
    data, hist(
      Global_active_power, main = "Global Active Power", col = "red" , xlab = "Global Active Power (kiloWatts)"
    )
  )
  dev.copy(png, file = "plot1.png", width = 480, height = 480)
  dev.off()
  