# R_code_NO2.r
# 1. Set the working directory EN
setwd("C:/lab/EN")
# 2. Import the first image (single band)
#install.packages("raster")
library(raster)
EN01 <- raster("EN_0001.png")
# 3. Plot the image with the preferred Ramp Color Palette
cls <- colorRampPalette(c("Red", "pink", "orange", "yellow")) (100)
plot(EN01, col=cls)

# different colorRampPalette
# cls <- colorRampPalette(c("Blue", "light blue", "pink", "red")) (100)

# 4. Import the last image (13th) with the same color ramp palette

EN13 <- raster("EN_0013.png")
cls <- colorRampPalette(c("Blue", "light blue", "pink", "red")) (100)
plot(EN13, col=cls)
# già da una prima analisi dell'immagine vediamo che la situazione a fine marzo è migliorata molto dal punto di vista della concentrazione di NO2 

# 5. Make the difference between the two images and plot it 
# EN13- EN01 significa sottrarre i valori di gennaio ai valori di marzo
# la scala dei valori potrebbe anche essere negativa
# per ottenere qualcosa di più intuitivo e più facile da apprezzare possiamo anche sottrarre i valori di marzo ai valori di gennaio
# EN01-EN13
ENdif <- EN13 - EN01
plot(ENdif, col=cls)
# ENdif <- EN01 - EN13
# plot(ENdif, col=cls)

# 6. plot everything 
par(mfrow=c(3,1))
plot(EN01, col=cls, main="NO2 in January")
plot(EN13, col=cls, main="NO2 in March")
plot(ENdif, col=cls, main="Difference (January- March)")



