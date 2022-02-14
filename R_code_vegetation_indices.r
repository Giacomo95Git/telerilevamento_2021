# R_code_vegetation_indices
library(raster)
setwd("C:/lab/")
# associo con la funzione brick l'immagine scaricata .jpg all'ogetto utilizzando anche lo stesso nome
# non posso fare il plotRGB della sola immagine jpg, devo prima associarla ad un nuovo oggetto tramite la funzione brick
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#giorno 2
library(raster)
setwd("C:/lab/")
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
# difference vegetation index 
# DVI difference from NIR-RED
# per ottenere NIR associo l'oggetto defor1 al nome defor1.1 
# per ottenere RED associo l'oggetto defor1 al nome defor 1.2
# defor1.1, defor 1.2 e defor 1.3 hanno valori da 0 a 255
# valore max fino a 2^8=256 (valori da 0 a 255)
# range 8 bit e range 16 bit 
# i valori min e max del NDVI variano da -1 a +1 
# NDVI permette di paragonare due dati a differenza di DVI
# caso vegetazione/piante
# gran parte della radiazione rossa viene assorbita
# gran parte della radiazione infrarossa viene riflessa
# in realtà la riflettanza nel RED non è mai zero, ma comunque è molto bassa
dvi1 <- defor1$defor1.1 - defor1$defor1.2
plot(dvi1)
dev.off()
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl)
plot(dvi1, col=cl, main="DVI at time 1")
# difference vegetation index 2 
dvi2 <- defor2$defor2.1 - defor2$defor2.2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI2 at time 1")
par(mfrow=c(1,2))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI2 at time 1")
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI2 at time 1")
#differenza dvi
difdvi <- dvi1 - dvi2
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld)
#NDVI
# (NIR-RED)/(NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(ndvi1, col=cl)
# si potrebbe anche scrivere in un modo più immediato
ndvi1 <- (dvi1) / (defor1$defor1.1 + defor1$defor1.2)
# un problema subentrerebbe se dovessi passare questo ndvi1 ad un collega
# il collega potrebbe non avere il dvi1 e quindi occorrerebbe mandare il codice più lungo
# RStoolbox : spectral indices
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(ndvi2, col=cl)
# RStoolbox : spectralIndices
vi1 <- spectralIndices(defor1, green=3, red=2, nir=1)
plot(vi1, col=cl)
vi2 <- spectralIndices(defor2, green=3, red=2, nir=1)
plot(vi2, col=cl)

difndvi <- ndvi1 - ndvi2
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difndvi, col=cld)

#giorno 3 05/05
install.packages("rasterdiv")
library(rasterdiv)
#worldwide NDVI
plot(copNDVI)
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
library(rasterVis)
levelplot(copNDVI)


