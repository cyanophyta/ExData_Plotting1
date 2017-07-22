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

png("plot2.png")
par(mfrow=c(1,1))

with(hcpdata, 
     plot(datetime, 
          Global_active_power, 
          type = "l", 
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))

dev.off()