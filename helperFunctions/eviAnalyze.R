### Author: JMZ
### Modified: 4/1/15
### Purpose: Initial start of functions that take downloaded MODIS EVI data and organizes them by year and day for analysis.
### The input will be a list of MODIS pixels that we will then analyze

### Known issues: Need to make sure flag files are downloaded, and this file will be added.

### Function that runs an R script to flag and make the temperature data

# Source the library of MODIS tools
library(MODISTools)


# Link to EVI product: https://lpdaac.usgs.gov/products/modis_products_table/mod13q1


### Identify the files needed to load up the data
dirSave = "MODISData"
qcBand = "250m_16_days_pixel_reliability"
bandName = "250m_16_days_EVI"
scaleFactor = 0.0001;


# Call up the temperature and the data flags
eviData=MODISTimeSeries(Dir = dirSave, Band = bandName,Simplify=TRUE)
eviFlag=MODISTimeSeries(Dir = dirSave, Band = qcBand,Simplify=TRUE)
# Mark the temperature flags that are invalid data as NA (see link above)
eviData[which(eviFlag!=0)]=NA;


nSites=length(colnames(eviData))

# Define a quick function that converts the tempeature data from Kelvin to celsius
eviData = eviData*scaleFactor


# Define a quick function that returns the year, day, and temperature from a given list data
source("helperFunctions/dataFrameExtract.R")


# Convert this into a data frame by pixel and year
eviData=dataFrameExtract(eviData)
nColumns = dim(eviData)[2]

# Compute an average yearly cycle for each site - representative
source("helperFunctions/yearlyCycle.R")

# Compute a yearly cycle of evi data (95% CI)
eviCycleData=yearlyCycle(eviData$day,as.matrix(eviData[,-(1:2)]))





