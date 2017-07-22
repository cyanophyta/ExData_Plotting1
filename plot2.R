library(lubridate)
library(dplyr)

hcp <- read.table("data/household_power_consumption.txt", 
                  header = TRUE, 
                  sep = ";", 
                  stringsAsFactors = FALSE,
                  colClasses = c("character","character", rep("numeric",7)), 
                  na.strings = "?")
hcpdata <- subset(hcp, year(as.Date(Date, "%d/%m/%Y")) == 2007)
rm(hcp)
hcpdata <- subset(hcpdata, month(as.Date(Date, "%d/%m/%Y")) == 02)
hcpdata <- subset(hcpdata, day(as.Date(Date, "%d/%m/%Y")) <= 02)

datef <- "%Y-%m-%d %H:%M:%S"
basetime <- strptime("2007-02-01 00:00:00", format = datef)
hcpdata <- hcpdata %>% 
  mutate(Date = as.Date(Date, "%d/%m/%Y")) %>% 
  mutate(timediff = difftime(strptime(paste(Date, Time), format = datef), 
                             basetime, 
                             units = c("mins")))


png("plot2.png")
par(mfrow=c(1,1))
# draw blank graph setting y-axis (Global active power) and keeping 
# timediff in x-axis (no tickmarks, no label at x-axis)
with(hcpdata, 
     plot(timediff, 
          Global_active_power, 
          type = "n", 
          xaxt = "n", 
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))
# then call axis function to label x-axis: Thu, Fri, Sat at timediff
# values 0, 1440, 2880
axis(1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
# then call lines to draw line graph
with(hcpdata, lines(timediff, Global_active_power))

dev.off()