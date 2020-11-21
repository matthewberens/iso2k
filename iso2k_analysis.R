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

# =============================================================================
# load Iso2k database
# =============================================================================

load("iso2k1_0_0.RData") # change this to match the current R serialization.
#rm(D, TS) # Remove extraneous objects
mapLipd(D, global = TRUE,size = 3) + ggtitle("iso2k v1.0.0") # Visual archive coverage

#==============================================================================
# Exclude non-isotope data
#==============================================================================

paleoData_isotopes <- sTS %>% 
  filterTs("paleoData_variableName == d18O || d2H") %>%
  filterTs("paleoData_units == permil") %>%
  filterTs("paleoData_iso2kPrimaryTimeseries == TRUE")
 #add line
