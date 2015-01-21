### Function that runs an R script to flag and makr the temperature data

# Source the 
library(MODISTools)


# Link to LST product: https://lpdaac.usgs.gov/products/modis_products_table/mod11a2
5000
#test
### Identify the files needed to load up the data
dirSave = "MODISData"
qcBand = "QC_day"
bandName = "LST_Day_1km"
scaleFactor = .02;

# Call up the temperature and the data flags
 temperatureData=MODISTimeSeries(Dir = dirSave, Band = bandName,Simplify=TRUE)
 temperatureFlag=MODISTimeSeries(Dir = dirSave, Band = qcBand,Simplify=TRUE)

# Mark the temperature flags that are invalid data as NA (see link above)

# temp[which(tempFlag!=0)]=NA;

# Multiply by the scale factor and then 
# temp = temp*scaleFactor - 273.15;
# 
# # remove row names
# rownames(temp)=NULL
# 
# # Convert days to decimal days for ease of access
# dataTimes = strptime(row.names(temp),format="A%Y%j");
# year = as.numeric(format(dataTimes, "%Y"))
# day = as.numeric(format(dataTimes, "%j"))
# 
# # Make a data frame from results
# temperatureData = data.frame(yearValue = year, dayValue=day,temp)
# 
# 
# 
# data=MODISTimeSeries(Dir = dirSave, Band = bands[2],Simplify=TRUE)
# dataFlag=MODISTimeSeries(Dir = dirSave, Band = bands[1],Simplify=TRUE)
# 
# # Remove the data the are not of good quality (see the MODIS product )
# data[which(dataFlag!=0)]=NA;
# 
# 
# 
# 


############################################
## If all bands use the same QA band, they can be summarised together
# MODISSummaries(LoadDat=dat, Dir = "MOD13Q1_IndividualPixel", Product = products, Bands = bands[2], ValidRange = c(-2000, 10000), NoDataFill = -3000, ScaleFactor = 0.0001, StartDate = TRUE, Interpolate = TRUE, Yield = TRUE, QualityScreen = TRUE, QualityBand = bands[1], QualityThreshold = 0, DiagnosticPlot = TRUE)
# 
# 
# MODISSummaries(LoadDat=dat, Dir = "MOD13Q1_IndividualPixel", Product = products, Bands = bands[2], ValidRange = c(-2000, 10000), NoDataFill = -3000, ScaleFactor = 0.0001, StartDate = TRUE)
# 
## Should now be a file with the MODIS data appended to our original data in the folder "MOD13Q1_IndividualPixel", ready for analysis

# ############
# ########## Larger Tiles ############
# 
# if(file.exists("MOD13Q1_6x6km") == FALSE)
#   dir.create("MOD13Q1_6x6km")
# 	
# ## Call to download the subsets
# MODISSubsets(dat, Products = products, Bands = bands, Size = c(3,3), SaveDir = "MOD13Q1_6x6km", TimeSeriesLength = 2)
# 
# 
# # To make sure that all time-series were downloaded, run the data frame through update subsets
# # to create a new data frame of all the site that might have failed to download first time through
# take2 <- UpdateSubsets(dat,StartDate = FALSE, Dir = "MOD13Q1_6x6km")
# 
# # Now to use MODISSubsets again
# MODISSubsets(take2, Products = products, Bands = bands, Size = c(3,3), SaveDir = "MOD13Q1_6x6km", TimeSeriesLength = 2)
# 
# MODISTimeSeries(Dir = "MOD13Q1_6x6km", Band = "250m_16_days_EVI")
# 
# ############################################
# ## If all bands use the same QA band, they can be summarised together
# MODISSummaries(dat, Dir = "MOD13Q1_6x6km", Product = products, Bands = bands[2], ValidRange = c(-2000, 10000), NoDataFill = -3000, ScaleFactor = 0.0001, StartDate = FALSE, Interpolate = TRUE, Yield = TRUE, QualityScreen = TRUE, QualityBand = "250m_16_days_pixel_reliability", QualityThreshold = 1)
# 
# ## Should now be a file with the MODIS data appended to our original data in the folder "MOD13Q1_6x6km", ready for analysis