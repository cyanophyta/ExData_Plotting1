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

png("plot1.png")
par(mfrow=c(1,1))
# draw histogram of Global active power with color red, 
#title "Global Active Power", x-axis label "Global Active Power (kilowatts)"
hist(hcpdata$Global_active_power, 
     col="red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()