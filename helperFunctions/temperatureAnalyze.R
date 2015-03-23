### Author: JMZ
### Modified: 3/23/15
### Purpose: Initial start of functions that take downloaded MODIS LST data and organizes them by year and day for analysis.
### The input will be a list of MODIS pixels that we will then analyze

### Known issues: Need to make sure flag files are downloaded, and this file will be added.

### Function that runs an R script to flag and make the temperature data

# Source the 
library(MODISTools)


# Link to LST product: https://lpdaac.usgs.gov/products/modis_products_table/mod11a2


### Identify the files needed to load up the data
dirSave = "MODISData"
qcBand = "QC_day"
bandName = "LST_Day_1km"
scaleFactor = .02;


# Call up the temperature and the data flags
 temperatureData=MODISTimeSeries(Dir = dirSave, Band = bandName,Simplify=TRUE)
# temperatureFlag=MODISTimeSeries(Dir = dirSave, Band = qcBand,Simplify=TRUE)
# Mark the temperature flags that are invalid data as NA (see link above)
# temperatureData[which(temperatureFlag!=0)]=NA;
# - 3/25/15: temperature flags are not incorporated yet.

# Define a quick function that converts the tempeature data from Kelvin to celsius
convertKelvins <- function(x,scaleFactor) x*scaleFactor-273.15


# Convert all of the temperature data to celsius
temperatureData =lapply(temperatureData,convertCel,scaleFactor)

# Define a quick function that returns the year, day, and temperature from a given list data
dataFrameTemperature <- function(x) {
  dataTimes = strptime(row.names(x),format="A%Y%j");
  rownames(x)=NULL
  year = as.numeric(format(dataTimes, "%Y"))
  day = as.numeric(format(dataTimes, "%j"))
  return(data.frame(year,day,temperature=x[,1]))
  
}



