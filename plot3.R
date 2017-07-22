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

png("plot3.png")
par(mfrow=c(1,1))
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
       lty = 1)
dev.off()