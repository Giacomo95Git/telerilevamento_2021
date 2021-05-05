# R_code_land_cover
library(raster)
library(RStoolbox)
install.packages("ggplot2")
library(ggplot2)
setwd("C:/lab/")
defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1 , g=2, b=3, stretch="lin")
#gg R function
ggRGB(defor1, r=1 , g=2, b=3, stretch="lin")
defor2 <- brick("defor2.jpg")
ggRGB(defor2, r=1 , g=2, b=3, stretch="lin")
par(mfrow=c(1,2))
plotRGB(defor1, r=1 , g=2, b=3, stretch="lin")
plotRGB(defor2, r=1 , g=2, b=3, stretch="lin")
# la funzione par con gg non funziona
# occorre un'altra funzione per creare un'unica immagine con gg
par(mfrow=c(1,2))
ggRGB(defor1, r=1 , g=2, b=3, stretch="lin")
ggRGB(defor2, r=1 , g=2, b=3, stretch="lin")
# multiframe con ggplot2 e gridExtra
install.packages("gridExtra")
library(gridExtra)
p1 <- ggRGB(defor1, r=1 , g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1 , g=2, b=3, stretch="lin")
# serve la funzione grid.arrange
grid.arrange(p1,p2, nrow=2)



