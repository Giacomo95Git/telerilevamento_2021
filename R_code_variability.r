# R_code_variability.r
library(raster)
library(RStoolbox)
setwd("C:/lab/")
sent <- brick("sentinel.png")
#NIR 1 RED 2 GREEN 3
# r=1 g=2 b=3 
# plotRGB (sent, stretch="lin")
plotRGB(sent) #plotRGB(sent, r=1, g=2, b=3 , stretch="lin")
# infrarosso sul green
# vegetazione verde fluorescente
# acqua "nera" molto ben visibile
plotRGB(sent, r=2, g=1, b=3 , stretch="lin")
nir <- sent$sentinel.1
red <- sent$sentinel.2
ndvi <- (nir-red)/ (nir+red)
plot(ndvi) # aree bianche specchi d'acqua ad esempio
cl <- colorRampPalette(c("black","white","red", "blue", "green")) (100)
plot(ndvi, col=cl)
# funzione focal
# calcoliamo la statistica nell'intorno della moving window
# statistica come ad esempio media o deviazione standard
# es. fun="mean" per la media
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvisd3, col=clsd)
# mean ndvi with focal
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvimean3, col=clsd)
# cambio la grandezza della finestra
# non più finestra 3x3 ma ad esempio 13x13 pixel
# ndvisd13
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvisd13, col=clsd)
# cambio finestra da 3x3 a 5x5
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvisd5, col=clsd)

#PCA
sentpca <- rasterPCA(sent)
plot(sentpca$map)
sentpca
summary(sentpca$model)
# la prima componente PC1 spiega circa il 67% della variabilità dell'informazione originale
# Proportion of Variance  0.6736804  0.3225753 0.003744348      0
# valore preciso 67,36% 




