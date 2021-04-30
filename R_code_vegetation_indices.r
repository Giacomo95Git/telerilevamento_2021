# R_code_vegetation_indices
library(raster)
setwd("C:/lab/")
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#giorno 2
library(raster)
setwd("C:/lab/")
