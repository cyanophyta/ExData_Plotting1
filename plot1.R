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
hcpdata <- hcpdata %>% 
  mutate(Date = as.Date(Date, "%d/%m/%Y")) 

png("plot1.png")
par(mfrow=c(1,1))
# draw histogram of Global active power with color red, 
#title "Global Active Power", x-axis label "Global Active Power (kilowatts)"
hist(hcpdata$Global_active_power, 
     col="red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()