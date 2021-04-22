# R code classification
# classificazione delle immagini 
# accorpo immagini con pixel simili in CLASSI
# Esempio di Classe = tipo di bosco,prateria o vegetazione in generale
setwd("C:/lab/")
library(raster)
library(RStoolbox)
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# visualizzazione RGB
plotRGB(so, 1, 2, 3, stretch="lin")
#classificazione
#classificazione non supervisionata
#il software classifica in automatico tutti gli altri pixel in funzione del trading set creato
#calcolo distanze spettrali
#concetto di "Maximum likeness"
# la funzione unsuperClass serve proprio per operare la classificazione non supervisionata
# attenzione la c è sempre maiuscola 
# R key sensitive
# scelgo il file
# scelgo il numero di classi
# ci sarebbero anche altri argomenti come nstarts
# nsamples per esempio lo posso vedere selezionando l'oggetto in R
# rinomino l'immagine scaricata 
# esempio soc
soc <- unsuperClass(so, nClasses=3)
#tramite funzione unsuperClass creo sia un modello che una mappa
#voglio solo plottare la mappa
#lego l'oggetto mappa a soc tramite $
plot(soc$map)
# classificazione non supervisionata con 20 classi
# ipotesi 20 classi con energia diversa
# ipotesi molto difficile 
soi <- unsuperClass(so, nClasses=20)
plot(soi$map)
# download image from 
# https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
# "sun.gif"
sun <- brick("sun.gif")
sunc <- unsuperClass(sun, nClasses=3)
plot(sunc$map)
# scelgo una colorRampPalette
cl <- colorRampPalette(c('yellow','red','black'))(100)
plot(sunc$map,col=cl)
