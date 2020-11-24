# =============================================================================
# set display options
# =============================================================================

options(scipen = 10, digits = 4) # removes scientific notation

# =============================================================================
# load required packages
# =============================================================================

library(magrittr)
library(tidyverse)
library(lipdR)
library(devtools)
library(ggplot2)
library(geoChronR)

# =============================================================================
# load Iso2k database
# =============================================================================

load("iso2k1_0_0.RData")
rm(D, TS) # Remove extraneous objects
#mapLipd(D, global = TRUE,size = 3) + ggtitle("iso2k v1.0.0") # Visual archive coverage

#==============================================================================
# Exclude non-isotope data
#==============================================================================

tTS <- tidyTs(sTS, age.var = "year")

paleoData_isotopes <- tTS %>% 
  filterTs("paleoData_variableName == d18O || d2H") %>%
  filterTs("paleoData_units == permil") %>%
  filterTs("paleoData_iso2kPrimaryTimeseries == TRUE")

# Look only at high-latitude (>50 N) lake sediments
LakeSediment_hiLat <- paleoData_isotopes %>%  
  filterTs("archiveType == LakeSediment") %>%
  filterTs("geo_latitude >= 50")

plot.ts <- LakeSediment_hiLat %>% 
  group_by(paleoData_TSid) %>%
  arrange(archiveType)

plotTimeseriesStack(tTS)


# Work in tidyverse



iTS_arcticLS <- tTS %>%
  filter(between(geo_longitude,0,50)) %>%  #only European longitudes
  filter(between(geo_latitude,20,60)) %>%  #between 20 and 60 N
  filter(interpretation1_variable == "T") %>% #only variables sensitive temperature
  group_by(paleoData_TSid) %>% #group by column
  arrange(archiveType) #and sort by archiveType
  


tm <- iTS_arcticLS %>%
  mapTs(iTS_arcticLS,
            projection = "stereographic", #for polar projections
            global = FALSE,
            shape = "archiveType",
            color = "paleoData_variableName",
            size = 4,
            bound.circ = TRUE
)
tm

# Accomplish with geoChronR



