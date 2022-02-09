# Il mio primo codice in R per il telerilevamento
# setwd("C:/lab/") # Windows
#install.packages("raster")
library(raster)
# la funzione library richiama il pacchetto che abbiamo installato su R
setwd("C:/lab/")
# con la funzione setwd spieghiamo ad R dove andare a "pescare" i dati
# i dati sono all'interno della cartella lab
# la cartella lab deve essere creata nell'unità C: e non sul desktop
# La funzione setwd viene settata in questo modo per il sistema windows
# per Mac o per Linus la funzione setwd sarebbe diversa
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# la funzione brick serve a importare tutto il pacchetto dell'immagine satellitare
# il pacchetto relativo all'immagine satellitare è denominato "p224r63_2011_masked.gdr"
# posso associare la funzione brick ad un certo oggetto 
# il file "p224r63_2011_masked.grd" viene associato a p224r63_2011 tramite la funzione brick
p224r63_2011
# informazioni dirette sul file come la sua classe, la sua risoluzione o la sua dimensione ecc.
plot(p224r63_2011)
# la funzione plot plotta in R il file selezionato
# Immagini analizzate nelle bande dal blu all'infrarosso termico (da B1 a B6)
# B1 banda del blu
# B2 banda del verde
# B3 banda del rosso
# B4 banda dell'infrarosso
# da B4 a B7 tutte bande relative all'infrarosso
# esempio: B7 banda dell'infrarosso medio come B5 
cl <-colorRampPalette(c("black", "grey", "light grey")) (100)
# cambio colori
# (100) definisce il numero dei livelli dei colori 
# la funzione colorRampPalette permette di stabilire la nuova scala di colori
# associo la funzione all'elemento "cl"
plot(p224r63_2011, col=cl)
# "col" è un argomento della funzione plot che serve a stabilire i colori
# color change new
cl <-colorRampPalette(c("blue", "green", "red", "yellow", "white")) (100)
plot(p224r63_2011, col=cl)
# la funzione plot ha due argomenti all'interno della parentesi
# il primo argomento è l'oggetto
# il secondo argomento è col=cl che restituisce l'oggetto con la scala di colori stabilita

# R è key sensitive
# occhio alle virgole, agli spazi e alle minuscole/maiuscole


#day3
library(raster)
setwd("C:/lab/")
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
plot(p224r63_2011)
cl <-colorRampPalette(c("blue", "green", "red", "yellow", "white")) (100)
#Bande Landsat
#B1:blu
#B2:verde
#B3:rosso
#B4:infrarosso vicino
#B5:infrarosso medio
#B6:infrarosso termico
#B7:infrarosso medio
#dev.off ripulisce la finestra grafica 
dev.off()
# spieghiamo che una certa banda va legata al dataset con la funzione $
# $ per legare due blocchi
plot(p224r63_2011$B1_sre)
#plot Banda 1 con una scala di colori decisa dall'operatore
cl <-colorRampPalette(c("blue", "green", "red", "yellow", "white")) (100)
plot(p224r63_2011$B2_sre, col=cl)
plot(p224r63_2011$B2_sre)
# par stabilisce come fare il plottaggio e mettere due bande una accanto all'altra evitando immagini sovrascritte
# 1 riga 2 colonne
# la funzione par permette di fare un plottaggio di più bande per avere una visione più completa 
# dopo aver richiamato la funzione par faccio il plot delle singole bande
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
# 2 righe 1 colonna
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#se uso prima le colonne uso mfcol invece che mfrow
par(mfcol=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#plottiamo le prime 4 bande di Landsat
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)
# set due righe e due colonne 
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)
par(mfrow=c(2,2))
# una scala di colori più vicini e simili alla singola banda, per tutte e 4 le bande
# scala di colori dal "dark blue" al "light blue" per la banda del blu
clb <-colorRampPalette(c("dark blue", "blue", "light blue")) (100)
plot(p224r63_2011$B1_sre,col=clb)
# scala di colori dal "dark green" al "light green" per la banda del verde
clg <-colorRampPalette(c("dark green", "green", "light green")) (100)
plot(p224r63_2011$B1_sre,col=clg)
# scala di colori dal "dark red" al "pink" per la banda del rosso
clr<-colorRampPalette(c("dark red", "red", "pink")) (100)
plot(p224r63_2011$B1_sre,col=clr)
# scala di colori dal "red" al "yellow" per la banda dell'infrarosso
clnir<-colorRampPalette(c("red", "orange", "yellow")) (100)
plot(p224r63_2011$B1_sre,col=clnir)

# R è key sensitive
# occhio alle virgole, agli spazi e alle minuscole/maiuscole


# day 4
# data by RGB plotting
library (raster)
setwd("C:/lab/")
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
#Bande Landsat
#B1:blu
#B2:verde
#B3:rosso
#B4:infrarosso vicino
#B5:infrarosso medio
#B6:infrarosso termico
#B7:infrarosso medio
# plot RGB viene montato lo schema RGB(red green blue) su un oggetto raster multilayered (multibanda)
# banda 3 sul rosso, banda 2 sul verde, banda 1 sul blu
# immagine satellitare a colori naturali
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
# plot RGB ma con banda 4(infrarosso) sul rosso, banda 3 sul verde, banda 2 sul blu
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
# plot RGB ma con banda 4 sul verde, banda 3 sul rosso, banda 2 sul blu 
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
# monto la banda 4 sul blu
plotRGB(p224r63_2011,r=3,g=2,b=4,stretch="Lin")
# multiframe 2x2 con le 4 bande con la funzione par
#par permtte il settaggio dei parametri grafici es. due righe due colonne
par(mfrow=c(2,2))
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4,stretch="Lin")
#funzione pdf per convertire un'immagine satellitare in pdf
# parentesi e virgolette con all'interno il nome che ho scelto per il file
# il nome deve essere seguito da .pdf
pdf("ilmioprimopdf.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4,stretch="Lin")
# al termine del plot scrivo dev.off() e il file viene generato
dev.off()
# funzione diversa, non lineare, molto più accentuata al centro
#stretch "hist" non lineare anzichè stretch "Lin" lineare
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="hist")
# par con colori naturali, falsi colori con funzione lineare e falsi colori con funzione non lineare
# par 3 righe 1 colonna
par(mfrow=c(3,1))
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="hist")
#installazione pacchetto RStoolbox tramite funzione install.packages
#virgolette nella parentesi perchè stiamo uscendo da R e portando in R successivamente il pacchetto
install.packages("RStoolbox")
#no virgolette perchè oramai RStoolbox è dentro R 
library(RStoolbox)

# R è key sensitive
# occhio alle virgole, agli spazi e alle minuscole/maiuscole


#day 5
library(raster)
setwd("C:/lab/")
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
#multitemporal set
# voglio fare un'analisi multitemporale della stessa area
# plotto tramite la funzione plotRGB l'immagine relativa al 1988 e quella relativa al 2011
# tramite la funzione par le visualizzo graficamente assieme per compararle
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988
plot(p224r63_1988)
# serie di plot prova a colori naturali o con banda dell'infrarosso sul rosso
plotRGB(p224r63_1988,r=3,g=2,b=1,stretch="Lin")
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="Lin")
par(mfrow=c(2,1))
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
# plotRGB sia con stretch lineare che non lineare per osservare le differenze 
# in alcuni casi può essere opportuno tenere lo strech non lineare
# con stretch "hist" posso apprezzare oggetti che con stretch lineare non vedo bene
par(mfrow=c(2,2))
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="hist")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="hist")
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="hist")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="hist")
dev.off()

# R è key sensitive
# occhio alle virgole, agli spazi e alle minuscole/maiuscole
