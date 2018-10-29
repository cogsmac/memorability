#  Author: Caitlyn McColeman
#  Date Created: Oct 29 2018
#  Last Edit: 
#
#  Visual Thinking Lab, Northwestern University
#  Originally Created For: memorability project
#
#  Reviewed: []
#  Verified: []
#
#  INPUT: loads "climatedata.csv" from current directory. That data is from ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_mm_mlo.txt and was published on social media (https://climate.nasa.gov/vital-signs/carbon-dioxide/?fbclid=IwAR2rmU6-0OGcD-SffeAakfxNkuNDV3YiPWQtq49oRiorC2C2cFiejYTF9MM)
#
#  OUTPUT: a base graph that we can do some post-processing on for the memorability study.
#
#  Additional Comments: our original plan was to go far into pre-history with ice cores but we're struggling to find consistent dataset to match to modern CO2 predictions
#
#  Additional Scripts Used: ggplot package

# prepare packages
library(ggplot2)
library(Hmisc) #used to convert year/mm/dd dates into decimals
library(curl)  #used to pull data from NOAA's FTP 

# Set working directory to source file directory & use it as a reference point loading data and saving the figure.
currDir = dirname(sys.frame(1)$ofile)
setwd(currDir) 

# === 1. gather, process and plot data for CARBON DIOXIDE levels at Mauna Loa Observatory
dataIn = read.table("climatedata.csv", sep=',','header'=T) # the header isn't super human readable but we'll replace variable names with appropriate fonts during post processing outside of R 

# the data contains placeholder values (e.g. missing Day = -1); replace with NaN to avoid errors in plotting and stats 
                              dataIn$dayCorrect = dataIn$Day     # copy original values 
            dataIn$dayCorrect[dataIn$Day == -1] = NA             # correct nonsense  

                          dataIn$averageCorrect = dataIn$average # copy original values
dataIn$averageCorrect[dataIn$average == -99.99] = NA             # correct nonsense 

# visualize that clean data (average Co2 vs date as decimal)
climateGraph = ggplot(data = dataIn) + geom_line(aes(x=decDate, y=average))


# === 2. gather, process and plot data for TEMPERATURE at Mauna Loa Observatory

# loop through the years of possible data and gather each associated year from FTP. Range was determined by visual inspection at https://www.esrl.noaa.gov/gmd/dv/data/index.php?site=mlo 
yearsAvailable = 1977:2017

# gather data from NOAA for each year. This strategy is a little fragile. If there's a problem, check this URL to see if needs updated.
pullFromFTPURL = paste('ftp://aftp.cmdl.noaa.gov/data/meteorology/in-situ/mlo/met_mlo_insitu_1_obop_hour_', as.character(yearsAvailable[1]) , '.txt', sep = '')

connectToHandle = new_handle(dirlistonly=TRUE)
   connectionID = curl(pullFromFTPURL, "r", connectToHandle)
   thisYearData = read.table(connectionID, stringsAsFactors=TRUE, fill=F)
close(connectionID)
> head(tbl)