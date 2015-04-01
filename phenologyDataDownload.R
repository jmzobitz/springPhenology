## phenologyDataDownload.R
## Script for downloading MODIS vegetation indices for analysis
## conducted in: Tuck et al. MODISTools – downloading and processing MODIS
## remotely-sensed data in R.
## Author: Helen Phillips, modified by JMZ
## Analysis done on a MAC computer (10.8.5).


### Validate model for 16 day annual GPP (MODIS) -- also use tower data if provided
### for each of these sites.
### Return back to daily LST for these sites to see the response

rm(list=ls(all=TRUE)) 
library(MODISTools)

sessionInfo()
# MODISTools_0.94.3

## setwd()

dat <- read.csv("Data/mnSites.csv")

## Making column names match what is needed by MODISTools
names(dat)[names(dat) == "Longitude"] <- "long"
names(dat)[names(dat) == "Latitude"] <- "lat"
names(dat)[names(dat) == "Sample_end"] <- "end.date"
names(dat)[names(dat) == "Sample_start"] <- "start.date"
#dat$end.date <- as.Date(dat$end.date,format='%y')
#dat$start.date <- as.Date(dat$start.date,format='%y')

## Creating my unique ID for each unique site
dat$ID <- paste(dat$SS, dat$lat, dat$long, dat$start.date, dat$end.date, sep=" ")

###############################
#### EVI and NDVI DOWNLOAD ####
###############################

## Specifying my product, and associated bands
products <- c("MOD13Q1","MOD11A2","MOD17A2_51")
bands <- c("250m_16_days_pixel_reliability", "250m_16_days_EVI","QC_Day","LST_Day_1km","Psn_QC_1km", "Gpp_1km")
dirSave = "MODISData"
if(file.exists(dirSave) == FALSE)
	dir.create(dirSave)

## Call to download the subsets
MODISSubsets(dat, Products = products, Bands = bands, Size = c(0,0), SaveDir = dirSave,StartDate=TRUE)


