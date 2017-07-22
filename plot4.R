library(lubridate)
library(dplyr)

hcp <- read.table("data/household_power_consumption.txt", 
                  header = TRUE, 
                  sep = ";", 
                  stringsAsFactors = FALSE,
                  colClasses = c("character","character", rep("numeric",7)), 
                  na.strings = "?")
hcpdata <- subset(hcp, Date %in% c("1/2/2007", "2/2/2007"))
rm(hcp)
hcpdata <- hcpdata %>% 
  mutate(datetime = strptime(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S"))

png("plot4.png")
par(mfrow=c(2,2))

#1st graph (plot2.R graph)
with(hcpdata, 
     plot(datetime, 
          Global_active_power, 
          type = "l", 
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))

#2nd graph
with(hcpdata, 
     plot(datetime, 
          Voltage, 
          type = "l", 
          xlab = "datetime",
          ylab = "Voltage"))

#3rd graph (plot3.R graph)
with(hcpdata, 
     plot(datetime, 
          Sub_metering_1, 
          type = "l", 
          col = "gray1",
          xlab = "",
          ylab = "Energy sub metering"))
with(hcpdata, lines(datetime, Sub_metering_2, col = "red"))
with(hcpdata, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", col=c("gray1", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       border = "white")

#4th graph
with(hcpdata, 
     plot(datetime, 
          Global_reactive_power, 
          type = "l", 
          xlab = "datetime",
          ylab = "Global Reactive Power"))

dev.off()