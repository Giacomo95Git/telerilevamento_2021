# R_code_variability.r
# lezione 19/05
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


# lezione 2 21/05 
library(raster)
library(RStoolbox)
setwd("C:/lab/")
sent <- brick("sentinel.png")
sentpca <- rasterPCA(sent)
plot(sentpca$map)
summary(sentpca$model)
# lego la map associata all'oggetto sentpca alla sola componente PC1 
pc1 <- sentpca$map$PC1
pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(pc1sd5, col=clsd)
# funzione source
# richiama un pezzo di codice già creato
# esempio di codice creato da un altro utente
# esempio di source
# source test lezione.r
# lo scarico da virtuale
pc1 <- sentpca$map$PC1
pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(pc1sd7, col=clsd)
source("source_test_lezione.r")
# ho ottenuto il risultato direttamente
# r mi ha aperto il plot 7x7 scritto nel codice che era stato scritto da qualcuno e caricato nella cartella lab
# operazione più immediata
# ovviamente posso modificare la colorRampPalette ad esempio andando a modificare il codice stesso
library(ggplot2)
library(gridExtra)
install.packages("viridis")
# viridis per la colorazione automatica del plot
library(viridis)
# source_ggplot.r codice scaricato da virtuale
source("source_ggplot.r")
# funzione ggplot
# creo una finestra nuova un pò come la funzione par
ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer))
# funzione scale_fill_viridis 
# c'è già una color ramp palette stabilita in questo caso, ma posso scegliere varie opzioni
ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis()
# inserisco anche il titolo, che potrebbe servire dopo con grid.arrange
p1 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis() + ggtitle("Standard deviation of PC1 by viridis colour scale")
# qui utilizzo ad esempio una color ramp palette tipo "magma"
p2 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option="magma") + ggtitle("Standard deviation of PC1 by magma colour scale")
# color ramp palette "inferno"
ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option="inferno") + ggtitle("Standard deviation of PC1 by inferno colour scale")
# color ramp palette "turbo", dal blu al rosso, non molto adatta in caso di soggetti daltonici!
p3 <- ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) + scale_fill_viridis(option="turbo") + ggtitle("Standard deviation of PC1 by turbo colour scale")
# con la funzione grid arrange creo una finestra in cui inserire tutti i miei ggplot precedenti con varie scale di colori
# posso vedere quale scala di colori è preferibile a seconda dell'oggetto o oggetti che voglio indagare
# in generale viridis utilizza il giallo come valori centrali ma l'occhio umano tende a considerare troppo il giallo perciò potrei pensare erroneamente che in giallo ci siano i valori massimi
grid.arrange(p1, p2, p3, nrow=1)






