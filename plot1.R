#This script produces plot 1 in Exploratory Data Analysis Course Project 1.

#The required zip file was downloaded into the course project directory as exdata-data-household_power_consumption.zip

#The working directory was set to this folder:
setwd("~/Documents/Coursera/1. DataScience/4.  Exploratory Data Analysis/Course Project 1")

#The downloaaded folder was manually un-zipped in that directory.
#Check  that the file, household_power_consumption.txt, is in the folder.
#If not, unzip the downloaded folder. 

if (!is.element('household_power_consumption.txt', dir())) {
    unzip('exdata-data-household_power_consumption.zip')
}

#We are advised to estimate the memory needed by this file before loading into R.
#The dataset has over 2 million rows and 9 columns. Using the formula
#"rowsxcolumnsx8 bytes per numeric" yields an estimated memory 149 Megabytes.
#My machine has 4GB so there should be sufficient memory for the entire file in R.

#Read the file into R, first checking to see if it's already been read in. If it has, no need
#to read again which will speed up re-running the script as adjustments are made.

if (!file.exists('household_power_consumption.txt')) {
    householdDf <- read.csv("household_power_consumption.txt", header=TRUE, sep=';', na.strings="?", 
            nrows=2075259, check.names=FALSE, stringsAsFactors=FALSE, comment.char="", quote='\"')
}

#The file was explored:
#Col 1 = Date in format dd/mm/yyy  (2006-12-16)  class = character
#Col 2 = Time in format hh:mm:ss (17:24:00)      class = character
#Col 3 = Global_active_power in kilowatt         class = numeric
#Col 4 = Global_reactive_power in kilowatt       class = numeric
#Col 5 = Voltage in volts                        class = numeric
#Col 6 = Global_intensity in amps                class = numeric
#Cols 7-9 = Sub_metering_1,2,3  Correpsonds to various household usage in watt-hr of active energy.

#Convert the character date entries to a date format:
householdDf$Date <- as.Date(householdDf$Date, format="%d/%m/%Y")

#Convert the character time entries to POSIXt so that calculations could be done on them:
householdDf$Time <- strptime(householdDf$Time, format="%s/%m/%h")

#Subset out the Feb 1-2, 2007 data specified in the project: :
FebData <- subset(householdDf, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# Generate the required plot for the assignment.
#First initialize the plot; store as a png file in the working directory
png("plot1.png", width=480, height=480)
hist(FebData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)",ylab="Frequency",col="blue")
dev.off()