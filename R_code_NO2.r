# R_code_NO2.r
# 1. Set the working directory EN
setwd("C:/lab/EN")
# 2. Import the first image (single band)
#install.packages("raster")
library(raster)
library (RStoolbox) 
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

# 7. Import the whole set with a single band
# tramite list.files creo una lista che rinomino rlist che contiene tutti le immagini dalla 1 alla 13 che hanno in comune la denominazione "EN"
rlist <- list.files(pattern="EN")
rlist

# utilizzo la funzione raster tramite la funzione lapply alla mia lista rlist e chiamo il nuovo oggetto "import"
import <- lapply(rlist, raster)
import 

EN <- stack(import)
plot(EN, col=cls)

# 8. Replicate the plot of images 1 and 13 using the stack 
# parto dallo stack e tramite par plotto le immagini 1 e 13
# lego l'oggetto EN alla singola banda nominata EN_0001 o EN_0013 tramite $
# il nome della banda lo vedo semplicemente scrivendo EN e trovandoli nella sezione "names"
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cls)
plot(EN$EN_0013, col=cls)

# 9. Compute a PCA over the 13 images 

ENpca <- rasterPCA(EN)
# con summary eseguo un sommario del mio modello ad esempio
# posso vedere come è spiegata la variabilità attraverso le PC
summary(ENpca$model)
plotRGB(ENpca$map, r=1, g=2, b=3, stretch="lin")

# 10. Compute the local variabiliy (local standard deviation) of the first PC
# la funzione local necessita del pacchetto raster
# la funzione local calcola la statistica nell'intorno della moving window
# con la moving window mi "muovo" da una matrice all'altra attraverso un certo valore matematico
# questo valore può essere la media aritmetica o la deviazione standard
# la matrice o finestra può essere di diverse dimensioni
# matrice 3x3 ok
# matrice o finestra 13x13 potrebbe risultare troppo grande, anche se dipende dall'ambiente e dall'analisi
# matrice 5x5 ideale
# con sd indico standard deviation
PC1sd<- focal(ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(PC1sd, col=cls)

