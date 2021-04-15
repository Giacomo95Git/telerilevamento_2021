# R_code_copernicus.r
# Visualizing Copernicus data
install.packages("ncdf4")
library(raster)
library(ncdf4)
setwd("C:/lab/")
burned <- raster("c_gls_BA300_202104100000_GLOBE_PROBAV_V1.1.1.nc")
burned 

