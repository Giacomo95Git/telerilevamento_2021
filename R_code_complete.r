# R_code complete - Telerilevamento geo ecologico 

# summary:

# 1. remote sensing first code
# 2. R_code_time_series.r 
# 3. R_code_copernicus.r 
# 4. R_code_knitr.r
# 5. R_code_multivariate_analysis.r
# 6. R_code_classification.r
# 7. R_code_ggplot2.r
# 8. R_code_vegetation_indices.r
# 9. R_code_land_cover.r
# 10.R_code_variability.r


# 1. remote sensing first code


# Il mio primo codice in R per il telerilevamento
# setwd("C:/lab/") # Windows
#install.packages("raster")
library(raster)
# la funzione library richiama il pacchetto che abbiamo installato su R
setwd("C:/lab/")
# con la funzione setwd spieghiamo ad R dove andare a pescare i dati
# i dati sono all'interno della cartella lab
# la cartella lab deve essere creata nell'unità :C e non sul desktop 
p224r63_2011 <- brick("p224r63_2011_masked.grd")
# la funzione brick serve a importare tutto il pacchetto dell'immagine satellitare
# posso associare la funzione brick ad un certo oggetto 
# il file "p224r63_2011_masked.grd" viene associato a p224r63_2011
p224r63_2011
# informazioni dirette sul file come la sua classe, la sua risoluzione o la sua dimensione ecc.
plot(p224r63_2011)
# la funzione plot plotta in R il file selezionato
# Immagini analizzate nelle bande dal blu all'infrarosso termico (da B1 a B6)
# B7 banda dell'infrarosso medio come B5 
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
pdf("ilmioprimopdf.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011,r=3,g=2,b=1,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=4,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=3,g=2,b=4,stretch="Lin")
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


#day 5
library(raster)
setwd("C:/lab/")
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
#multitemporal set
p224r63_1988 <- brick("p224r63_1988_masked.grd")
p224r63_1988
plot(p224r63_1988)
plotRGB(p224r63_1988,r=3,g=2,b=1,stretch="Lin")
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="Lin")
par(mfrow=c(2,1))
plotRGB(p224r63_1988,r=4,g=3,b=2,stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3,b=2,stretch="Lin")
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

#...............................................


# 2. R_code_time_series.r 


#day 1
#time series analysis
#greenland increase in Temperature 
#Data and core from Emanuela Cosma
install.packages("raster")
library(raster)
setwd("C:/lab/greenland")

#day 2
install.packages("raster")
library(raster)
setwd("C:/lab/greenland")
#cartella greenland con 4 file,4 strati separati
#i file .tif rappresentano la stima della temperatura LST
# LST= land surface temperature
# LST da Copernicus (Global Land Service)
#la funzione brick non può essere utilizzata perchè i 4 file sono 4 file separati
# uso la funzione raster
# raster crea un rasterlayer
# uso la funzione raster per ogni file lst_x.tif
lst_2000<- raster("lst_2000.tif")
lst_2005<- raster("lst_2005.tif")
lst_2010<- raster("lst_2010.tif")
lst_2015<- raster("lst_2015.tif")
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)
#list f files
# list.files crea la lista di file che R utilizzerà per la funzione lapply
# serve un path
# a noi il path non serve perchè abbiamo fatto la working directory
# serve un pattern
# pattern significa andare a cercare un certo tipo di file che ci interessa, es. i file .tif
# i file che ci interessano sono i file "lst"
rlist<- list.files(pattern="lst")
# la funzione lapply permette di applicare una funzione (es. raster) ad una lista di file (tipo quella dei file "lst")
# serve X ovvero la lista alla quale applicare la funzione
# serve FUN ovvero la funzione da applicare 
# X= rlist
# FUN= raster
# associo un nome all'oggetto ovvero "import"
import<- lapply(rlist,raster)
# la funzione stack permette di raggruppare un numero di file raster tutti assieme
# associo un nome all'oggetto ovvero "TGr"
TGr<- stack(import)
# così riesco a fare il plot dei file .tif in un attimo facendo il solo plot dell'ogggetto TGr appena creato
plot(TGr)
# utilizzo la funzione PlotRGB come nei casi studio precedenti
# scelgo uno stretch di tipo lineare
# scelgo le varie bande
plotRGB(TGr,1,2,3,stretch="Lin")
plotRGB(TGr,2,3,4,stretch="Lin")
plotRGB(TGr,4,3,2,stretch="Lin")

#day 3
library(raster)
library (rasterVis)
setwd("C:/lab/greenland")
lst_2000<- raster("lst_2000.tif")
> lst_2005<- raster("lst_2005.tif")
> lst_2010<- raster("lst_2010.tif")
> lst_2015<- raster("lst_2015.tif")
> rlist<- list.files(pattern="lst")
> import<- lapply(rlist,raster)
> TGr<- stack(import)
> TGr
# funzione levelplot più "raffinata" di plot
# plotto i file .tif in un unico grafico con un'unica barra
# immagine finale più sintetica ed efficace
levelplot(TGr)
# lego tramite $ due oggetti
# con $ lego TGr a lst_2000
# in questo modo riesco a vedere che dove ci sono temperature minori ricorrono anche i valori di media più bassi
levelplot(TGr$lst_2000)
# imposto la mia colorRampPalette per vedere ad esempio i ghiacci con il colore "Blue"
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)
# aggiungo un ulteriore argomento
# con names.attr=c do un nome ad ognuno dei quattro grafici
levelplot(TGr,col.regions=cl, names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
# aggiungo un ulteriore argomento
# con main= do un titolo al mio grafico finale
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
pdf("lstvar.pdf")
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
dev.off()
pdf("lstvar.pdf")
levelplot(TGr,col.regions=cl, main="LST variation in time",
          names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
dev.off()


#melt list
# scaricare i file dal pacchetto melt_greenland
# creo sempre una lista con la funzione list.files questa volta però con i file che hanno in comune "melt" e non più .tif
# grande utilità della funzione list.files
# evito di utilizzare la funzione raster per 28 volte
# uso la stessa funzione per raggruppare assieme 28 files
meltlist <- list.files(pattern="melt")
melt<- lapply(meltlist,raster)
# chiamo TMel il nuovo oggetto associato alla funzione stack
TMel<- stack(melt)
levelplot(TMel)
# faccio una prova con una nuova scala di colori
cl<- colorRampPalette(c("green","red","pink"))(100)
# inserisco anche un titolo per indicare la scala temporale analizzata dai files
levelplot(TMel,col.regions=cl, main="melt1979-2007")

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
# voglio quantificare graficamente la perdita di ghiaccio
# sottraggo la quantità di ghiaccio del 2007 a quella del 1979
# utilizzo $ per legare gli oggetti _melt all'oggetto TMel
# senza $ R darebbe errore perchè non troverebbe l'oggetto che si trova in un altro spazio
melt_amount <- TMel$X2007annual_melt-TMel$X1979annual_melt
clb <-colorRampPalette(c("blue","white","red"))(100)
plot(melt_amount,col=clb)
levelplot(melt_amount,col.regions=clb)
dev.off()


#...........................................................................................


# 3. R_code_copernicus.r 

# day 1
# R_code_copernicus.r
# Visualizing Copernicus data
install.packages("ncdf4")
library(raster)
library(ncdf4)
setwd("C:/lab/")
# dal sito Copernicus trovo una serie di gruppi come Vegetazione,energia, acqua e criosfera
# All'interno dei singoli gruppi una serie di variabili (ad esempio l'albedo)
# clicco sulla variabile e posso scaricare i miei dati scegliendo anche una finestra temporale precisa
# attenzione a scaricare i file
# i file devono essere quelli NC
# Rinomino il file .nc come burned
burned <- raster("c_gls_BA300_202104100000_GLOBE_PROBAV_V1.1.1.nc")
burned 
cl <-colorRampPalette(c("green", "yellow", "red")) (100)
plot(burned,col=cl)
# resampling
#ricampionamento
# res sta per resampling
# la funzione aggregate mi permette di lavorare sui pixel
# passaggio da un file a n pixel ad un file a m pixel (m<n)
# fact=10 significa che faccio la media di 10x10=100 valori o pixel ottenendo al loro posto un solo pixel
# se scrivo burnedres mi accorgo che nelle proprietà il numero di pixel è minore
# attenzione: posso perdere di molto la qualità dell'immagine 
burnedres <- aggregate(burned, fact=100)
dev.off()

#...........................................................................................................


# 4. R_code_knitr.r

#R_code_knitr.r

setwd("C:/lab/")
# la funzione require come la funzione library richiama il pacchetto scelto
# library o require è indifferente 
library(knitr)
# la funzione stitch crea automaticamente un report basato su uno script R e uno schema 
# lo script R è il file "R_code_greenland.r" 
# il pacchetto knitr è essenziale
# con stitch viene creato dentro R un report che poi verrà salvato nella cartella .r
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
# copio tutto il codice "time series"

#.................................................................................................

# 5. R_code_multivariate_analysis.r

#Giorno 1
# R_code_multivariate_analysis
setwd("C:/lab/")
library(raster)
library(RStoolbox)
p224r63_2011 <- brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
#immagini iperspettrali (es. sensori apex) con centinaia di bande
# scelgo due bande che rappresentano/spiegano la variabilità
# banda 1 spiega il 50% della variabilità
# banda 2 spiega il 50% della variabilità
# uso componenti principali allo scopo di compattare la variabilità
# PC1 e PC2 rispettivamente spiegano il 90% e il 10% della variabilità
# PC1 90% variabilità -> perdita del 10% di variabilità ma scopo raggiunto
# pch simbologia 
# pch utilizzo come singolo i pallini
# cex esagerazione 2x
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col=red, pch=19, cex=2) 
plot(p224r63_2011$B2_sre,p224r63_2011$B1_sre, col=red, pch=19, cex=2)
# funzione pairs
# matrix of scatterplots
# plotto tutte le correlazioni possibili tra tutte le variabili
# ottengo un immagine in cui riesco a vedere i grafici di correlazione tra le varie bande assieme agli indici di correlazione
# sette bande
# sette grafici di correlazione
# indici di correlazione di Pearson
# indici di correlazione di Pearson teorici variabili tra -1 e +1 
pairs(p224r63_2011)

#giorno 2 

#aggregate cell
# ricampionamento
#resample
# la funzione aggregate aggrega i pixel facendo una media con una risoluzione più bassa
# riduco la dimensione dell'immagine diminuendo la risoluzione
# aggregazione di pixel
# indico il nuovo oggetto con res(resample)
# l'argomento importante è "fact"
# "fact" rappresenta il fattore di riduzione della risoluzione es. fattore 10
# da dimensione 300*300 a 30*30
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
p224r63_2011res
# setto in due righe e 1 colonna i due plotRGB a dimensione 300*300 e 30*30
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4 ,g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res , r=4 ,g=3, b=2, stretch="lin")
# funzione rasterPCA compatta il pacchetto di dati in un numero minore di bande
# indico il nuovo oggetto con _pca
# mai usare il simbolo -
# il simbolo - viene letto come "meno" e non come trattino
#al nuovo oggetto viene associata una map e un modello
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
# con la funzione summary indico il sommario ad esempio del modello prodotto
# associo il nuovo oggetto al solo modello tramite $
summary(p224r63_2011res_pca$model)
#la PC1 spiega il 99,83% della variabilità
# con le prime tre componenti spiego il 99,998% della variabilità
# la PC1 solitamente spiega la % percentuale della variabilità
# faccio un plot del nuovo oggetto associandolo non più al suo modello ma alla mappa
plot(p224r63_2011res_pca$map)
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

#....................................................................................

# 6. R_code_classification.r

# Giorno 1
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
#concetto di "Maximum likelihood"
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
pdf("sun.pdf")
sun <- brick("sun.gif")
sunc <- unsuperClass(sun, nClasses=3)
cl <- colorRampPalette(c('yellow','red','black'))(100)
plot(sunc$map,col=cl)
dev.off()
# con la funzione setseed(numero x) faccio in modo che le repliche siano sempre le stesse per il modello
# con plot(soc$map) la combinazione dei 1000 pixel rimarebbe casuale
# setseed(42)
# miglioro la legenda con una scala più verosimile e valori più verosimili con ggplot


# Giorno 2
# Grand Canyon
# classificazione immagini Grand Canyon 
# download from https://landsat.visibleearth.nasa.gov/view.php?id=80948
setwd("C:/lab/")
library(raster)
library(RStoolbox)
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
plotRGB(gc,r=1,g=2,b= 3,stretch="lin")
plotRGB(gc,r=1,g=2,b= 3,stretch="hist")
gcc2 <- unsuperClass(gc, nClasses=2)
gcc2
plot(gcc2$map)
#plottaggio con 4 classi
gcc4 <- unsuperClass(gc, nClasses=4)
gcc4
plot(gcc4$map)

#.....................................................................................................................

# 7. R_code_ggplot2.r

library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("~/lab/")
p224r63 <- brick("p224r63_2011_masked.grd")
ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")
p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")
grid.arrange(p1, p2, nrow = 2) # this needs gridExtra

#..................................................................

# 8. R_code_vegetation_indices.r

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
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
# difference vegetation index 
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

#.....................................................................................................

# 9. R_code_land_cover.r

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

#giorno 2 07/05
library(raster)
library(RStoolbox) #classification
library(ggplot2)
library(gridExtra)
setwd("C:/lab/")
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")
ggRGB(defor1, r=1 , g=2, b=3, stretch="lin")
# unsupervised classification
# chiamo d1c il nuovo oggetto associato alla funzione unsuperClass
d1c <- unsuperClass(defor1, nClasses=2)
plot(d1c$map)
# d2c oggetto associato alla funzione unsuperClass e all'immagine defor2
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
par(mfrow=c(1,2))
plot(d1c$map)
plot(d2c$map)
#unsupervised classification con 3 classi
# d2c3 per distinguerlo da d2c con 2 classi
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)
# value count
# la funzione freq va a calcolare la frequenza
freq(d1c$map)
#ottengo due valori che andrò a sommare
# chiamo s1 l'oggetto somma 
s1 <- 34107+307185
# per ottenere la proporzione foreste e agricoltura faccio freq(d1c$map) diviso la somma
# chiamo l'oggetto prop1 riferito a d1c
prop1 <- freq(d1c$map)/s1
# prop forest 90%
# prop agricolo 10%
# faccio lo stesso per d2c ottenendo percentuali diverse
prop2 <- freq(d2c$map)/s2
# prop forest 52%
# prop agricolo 48%
# build a dataframe 
cover <- c("forest", "agriculture")
percent_1992 <- c(90.00, 0.09)
percent_2006 <- c(52.08, 47.91)
# la funzione data.frame crea un data frame con una serie di variabili
# associo alla funzione data.frame l'oggetto percentages
percentages <- data.frame(cover, percent_1992 , percent_2006)
percentages
#la funzione ggplot necessita di una serie di argomenti
# dataset= percentages
# aestetic con x= prima colonna y=seconda colonna color= tipo di colore
# geom_point o geom_bar in questo caso perchè vado a rappresentare delle barre
# geom_bar necessita di una serie di argomenti
# stat="identity" sono i dati originali, i dati grezzi
# fill=" " rappresenta il colore del riempimento delle barre che vado a rappresentare
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
# associo ai due ggplot rispettivamente oggetti chiamati p1 e p2
# in questo modo posso fare il grid.arrange direttamente degli oggetti p1 e p2 lavorando più velocemente
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="red")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="red")
grid.arrange(p1, p2, nrow=1)


#.........................................................................................................

# 10.R_code_variability.r

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

#...........................................................................................................................................................................









