#BENTORNATI SU r
#ESAME TELERILEVAMENTO
#CODICE ESAME
#Analisi delle variazioni di vegetazione nell'isola di Eubea in Grecia a seguito degli incendi dell'estate 2021
#Monitoraggio pre-post agosto 2021
#Climate change:gli incendi nel 2021 sono stati numerosi e la Grecia ha vissuto un'estate intensiva
#Eubea verso la fine di luglio e l'inizio di agosto 2019 colpita da incendi importanti
#distrutti più di 56 mila ettari di terreno secondo le ricostruzioni
#Nord dell'isola di Eubea(città di Pefki) colpita duramente da incendi
#richiamo innanzitutto la set working directory
#lavoro con la cartella ESAME creata nella cartella lab
#la cartella di lavoro lab deve essere nell'unità C:
#non può essere collocata su desktop
setwd("C:/lab/ESAME")
#richiamo attraverso la funzione library il pacchetto raster
#può essere usata anche la funzione acquire
#il pacchetto raster serve per sviluppare le immagini satellitari che scarico
library(raster)
#richiamo il pacchetto ncdf4
#il pacchetto ncdf4 servirà per la funzione aggregate
#con aggregate posso eventualmente ridurre i pixel di un'immagine
#fact=x sarà il fattore di scala per ridurre l'immagine
# es. fact=10 faccio la media di 10x10=100 valori e faccio un solo pixel
library(ncdf4)
#richiamo il pacchetto rasterVis 
library(rasterVis)
#il pacchetto RStoolbox è necessario per usare una funzione utile alla classificazione delle immagini
library(RStoolbox)
#il pacchetto rgdal è utile per la funzione click
# funzione click servirà sempre per la classificazione di immagini e indici di riflettività
library(rgdal)
library(ggplot2)

#Ho scaricato i dati originali Landsat dell'Isola di Eubea e aree limitrofe dal sito USGS Earth Explorer
#Search criteria ritaglio la zona di mio interesse
#Inserisco la finestra temporale di mio interesse
#In questo caso ci interessa fare un confronto tra pre Estate e post Estate 
#in particolare tra pre agosto e dopo agosto
# Scelgo con Data set i dati di mio interesse
# in questo caso ho scelto i dati relativi a Landsat8-9
#Livello 2 perchè è il livello nel quale è già stata applicata una correzione all'atmosfera
#il dato L2 è più corretto
#Scelgo le due immagini (con lo stesso codice riferito allo stesso quadrante) di due date differenti
# Scarico i file .tif relativi alle singole bande
# Landsat 8 bande
# Banda 2 blu
# Banda 3 green
# Banda 4 red
# Banda 5 infrared
# Ci interessa solo la banda 5 relativa al più vicino infrarosso
# rinomino i file
# Es. PRIMA_2 PRIMA_3 PRIMA_4 per i file relativi rispettivamente a banda 2,banda 3 banda 4 ecc..
# Per ottenere l'immagine a colori naturali non posso usare la funzione brick
# con brick prendo un intero pacchetto di dati di tutte le bande (che non ho)
# faccio uno stack delle singole bande
#definisco un pattern
# i file delle bande hanno in comune la sigla "PRIMA"
# richiamo tramite funzione list.files
# il nuovo oggetto lo rinomino rlistP
rlistP<-list.files(pattern="PRIMA")
# con la funzione lapply applico la funzione raster ad una lista di file (quelli rlist che hanno in comune PRIMA)
# lapply(x,FUN)
# X lista
# FUN funzione
# nomino l'oggetto ImportP
importP<-lapply(rlistP,raster)
# gruppo di file raster tutti assieme tramite la funzione stack
# nomino il fil BandeP
# Ora ho tutte le bande in un unico file raster
# rasterstack
BandeP<-stack(importP)
#faccio lo stesso con i file.tif relativi all'immagine satellitari posteriore, quella post agosto
# 25 maggio 2019
# 27 settembre 2019
rlistD<-list.files(pattern="DOPO")
importD<-lapply(rlistD,raster)
BandeP<-stack(importP)
BandeD<-stack(importD)
# Plotto le singole bande relative all'immagine satellitare di maggio
plot(BandeP,main="Bande della area di studio Maggio")
#plotRGB
# oggetto raster multilayered multibanda su cui viene montato lo schema RGB
#Schema RGB
#RED
#GREEN 
#BLU
#Se monto la banda 4 sul rosso, la banda 3 sul verde e la banda 2 sul blu ottengo il plot dell'immagine satellitare a colori naturali
plotRGB(BandeP, r=4, g=3, b=2)
# stretch="Lin" ottengo dei colori più nitidi e posso apprezzare eventualmente oggetti diversi anche con lo stretch="hist"
plotRGB(BandeP, r=4, g=3, b=2, stretch="Lin")
plotRGB(BandeP, r=4, g=3, b=2, stretch="hist")

# comparazione diversi plotRGB per apprezzare eventuali differenze e dettagli
# funzione par per settaggio griglia di lavoro
# mfrow primo numero riga secondo numero colonne
par(mfrow=c(2,2))

plotRGB(BandeP, r=4, g=3, b=2)
plotRGB(BandeP, r=4, g=3, b=2, stretch="Lin")
#infrarosso sul rosso per plotRGB diverso
# sfrutto il fatto che la vegetazione riflette molto nell'infrarosso, un pò meno nel rosso e così via
#Apprezzo già un'immagine satellitare diversa da quella a colori naturali
plotRGB(BandeP, r=5, g=3, b=2)
plotRGB(BandeP, r=5, g=3, b=2, stretch="Lin")

# posso utilizzare un plot più raffinato che è richiamato tramite la funzione levelplot
# assegno una scala di colori ben precisa
# assegno titolo (Bande Immagini Landsat come per il primo plot)
# assegno titoli ad ogni banda
levelplot(BandeP,col.regions=clvi,main="Bande immagine Landsat",names.attr=c("Banda1","Banda2","Banda3","Banda4","Banda5","Banda6","Banda7"))
#imposto una scala di colori appposita per la banda dell'infrarosso che mi aiuta ad apprezzare meglio la presenza di vegetazione
# la vegetazione riflette molto nella banda dell'infrarosso
#valori più alti di riflettanza per la vegetazione sana nella banda dell'infrarosso
clnir<-colorRampPalette(c("red", "orange", "yellow")) (100)
#aggancio lo stack alla sola banda 5 dell'infrarosso
levelplot(BandeP$PRIMA_5,col.regions=clnir)


# per la mia analisi di monitoraggio so che l'area centro-nord è stata la più colpita dagli incendi perciò potrebbe anche essere stata la zona più soggetta a variazioni di vegetazione o indici di vegetazione
# faccio uno zoom sull'area a Nord 
# utilizzo un determinato set di coordinate x e y per risalire all'area
#l'area di competenza va da valori di x di 680000 a valori di x di 720000
# stessa cosa per le y
# nomino l'oggetto ritagliato
ext_ggsD<-raster::extent(680000, 720000, 4300000, 4320000)
# uso la funzione crop
# Primo oggetto immagine di partenza, secondo oggetto ritaglio e area di interesse
# Vengono generati due cut, uno per l'immagine pre Agosto uno per l'immagine post Agosto
cutD<-crop(BandeD,ext_ggsD)
ext_ggsP<-raster::extent(680000, 720000, 4300000, 4320000)
cutP<-crop(BandeP,ext_ggsP)

#levelplot dell'area di ritaglio con la sola banda dell'infrarosso per vedere meglio la vegetazione e il suo stato di salute in toto
#la vegetazione può riflettere molto o poco nell'infrarosso a seconda del suo stato di salute
# potrei apprezzare delle differenze in questo modo
levelplot(cutP$PRIMA_5,col.regions=clnir)
levelplot(cutD$DOPO_5,col.regions=clnir)
######################################################################################################
#CLASSIFICAZIONE
# funzione unsuperClass
# classificazione dell'immagine
# argomenti sono nome dell'immagine, i pixel da utilizzare come training set (nSamples) e il numero di classi (nClasses)
# nClasses=5
# per visualizzare la mappa lego poi l'oggetto con l'elemento $ a map
# ogni oggetto genera a sua volta sia una mappa che un modello
cutPuc5<-unsuperClass(cutP,nClasses=5)
#imposto una scala di colori per le 5 classi
cl5<-colorRampPalette(c("black","red","green","yellow","white"))(100)
plot(cutPuc5$map,col=cl5)
# stesso procedimento per l'immagine ritagliata post agosto
# per cut D (immagine ritagliata dopo Agosto)
cutDuc5<-unsuperClass(cutD,nClasses=5)
plot(cutDuc5$map,col=cl5)1
par(mfrow=c(1,2))
plot(cutPuc5$map,col=cl5)
plot(cutDuc5$map,col=cl5)
# posso apprezzare già una differenza tra pre agosto e post agosto
# l'area più centrale e più orientale sembra aver mostrato una variazione maggiore
# interpretazioni classi 
# classe 1 Specchi d'acqua
# Classe 2 vegetazione meno sana
# Classe 3 terreni agricoli
# Classe 4 Centri abitati/prive vegetazione/aree più antropiche/meno vegetazione ma non danneggiate
# Classe 5 vegetazione più sana
# iterazioni infinite delle repliche delle mappe
# con la funzione click posso cliccare su un punto della mapppa e avere le informazioni che voglio relative alle bande
# banda dell'infrarosso molto interessante da confrontare 
# valori diversi
# esempi risultati
click(BandeP,id=T,xy=T,cell=T,type="p",pch=16,col="yellow")
# punto sul mare e più alti valori nella banda del 2 (escluso banda 6)
       x       y     cell PRIMA_1 PRIMA_2 PRIMA_3 PRIMA_4 PRIMA_5 PRIMA_6
1 715740 4311150 28773464    7316    7543    7476    7231    7363    7686
  PRIMA_7
# stesso procedimento per BandeD (DOPO)
click(BandeD,id=T,xy=T,cell=T,type="p",pch=16,col="yellow")

###################################################################################################################################################
# Calcolo indici di vegetazione
# DVI = NIR - RED
# Più corretto l' NDVI= (NIR-RED)/(NIR+RED)
# SE UTILIZZO DVI PER MAGGIO E SETTEMBRE IL CONFRONTO NON RIESCE PERCHE' I VALORI NON SONO CONFRONTABILI
# USANDO NDVI SI, EVITO PROBLEMI IN CASO DI RISOLUZIONI NON COMPARABILI PERCHE' NORMALIZZO
# Parto con l'analisi di tutta l'isola e dell'area attorno per vedere se anche altre zone hanno risentito dello stesso fenomeno
DVIP<-BandeP$PRIMA_5-BandeP$PRIMA_4
NDVIP<-DVIP/(BandeP$PRIMA_5+BandeP$PRIMA_4)
#imposto una scala di colori che mi permetta di apprezzare meglio la variazione delle classi
clndvi<-colorRampPalette(c("black","grey","red","orange","yellow","white"))(300)
plot(NDVIP,col=clndvi)
DVID<-BandeD$DOPO_5-BandeD$DOPO_4
NDVID<-DVID/(BandeD$DOPO_5+BandeD$DOPO_4)
plot(NDVID,col=clndvi)
par(mfrow=c(1,2))
plot(NDVIP,col=clndvi)
plot(NDVID,col=clndvi)

# posso anche procedere in un altro modo
vi<-spectralIndices(bandePres, red=4, nir=5)
clvi<-colorRampPalette(c("black","grey","red","orange","yellow","white"))(300)
plot(vi,col=clvi)
# ottengo una lista completa degli indici (tra cui l'NDVI e il DVI)
#plotto solo l'NDVI
# lo aggancio all'oggetto vi tramite $
plot(vi$NDVI,col=clvi)
#ottengo lo stesso risultato con ggr ma più raffinato e con scala di valori più completa


#faccio il calcolo degli indici di vegetazione solo per l'area di ritaglio

DVIPcut<-cutP$PRIMA_5-cutP$PRIMA_4
NDVIPcut<-DVIPcut/(cutP$PRIMA_5+cutP$PRIMA_4)
plot(NDVIPcut,col=clndvi)
DVIDcut<-cutD$DOPO_5-cutD$DOPO_4
NDVIDcut<-DVIDcut/(cutD$DOPO_5+cutD$DOPO_4)
plot(NDVIDcut,col=clndvi)
#faccio la differenza degli indici NDVI e lo chiamo NDVIdiff
# posso vedere dove si è verificata la maggior variazione(sottrazione)
NDVIdiff<-NDVIPcut-NDVIDcut
plot(NDVIdiff,col=clndvi)
# con levelplot faccio un plot più sofisticato
# posso vedere anche la % variazione dei dati in corrispondenza del settore Nord-centro-orientale
levelplot(NDVIdiff)
# utilizzo sempre la scala di colori clndvi più completa
levelplot(NDVIdiff,col.regions=clndvi)
levelplot(NDVIdiff)
# posso anche plottare senza scala di colori definita
# apprezzo comunque il dato
levelplot(NDVIdiff,main="Differenza NDVI Maggio-Settembre 2021")


# freq funzione che mi calcola la frequenza 
freq(cutPuc5$map)
#lego all'oggetto map da visualizzare
     value  count
[1,]     1 263203
[2,]     2   3560
[3,]     3 226218
[4,]     4  57629
[5,]     5 338523
[6,]    NA    645
#lego all'oggetto map da visualizzare
> freq(cutDuc5$map)
     value  count
[1,]     1 196738
[2,]     2 132796
[3,]     3 151752
[4,]     4 254360
[5,]     5 154132

# sommo i valori nella prima tabella (Maggio)
# nomino l'oggetto s come somma e pre come prima
# 5 per ricordare della unsuperClass con 5 classi
> spre5<-263203+3560+226218+57629+338523
# la proporzione la ottengo dividendo la frequenza per la somma
> proppre5<-freq(cutPuc5$map)/ spre5
> proppre5
            value        count
[1,] 1.124691e-06 0.2960220799
[2,] 2.249382e-06 0.0040039004
[3,] 3.374073e-06 0.2544253784
[4,] 4.498765e-06 0.0648148252
[5,] 5.623456e-06 0.3807338160
[6,]           NA 0.0007254258
# stesso procedimento per post (Settembre)
> spost5<-196738+132796+151752+254360+154132
> proppost5<-freq(cutDuc5$map)/spost5
> proppost5
            value     count
[1,] 1.123876e-06 0.2211091
[2,] 2.247752e-06 0.1492462
[3,] 3.371628e-06 0.1705504
[4,] 4.495503e-06 0.2858691
[5,] 5.619379e-06 0.1732252

# vedere la variazione di campi coltivati e di vegetazione (già in non ottimo stato) da Maggio a Settembre 
cover <- c("Vegetazione", "Campi coltivati")
percent_1992 <- c(90.00, 0.09)
plot(cutPuc5$map,col=cl5)
percent_Maggio <- c(25.44, 38.07)
plot(cutDuc5$map,col=cl5)
percent_Sett <- c(22.11, 17.05)
percentmesi <- data.frame(cover, percent_Maggio , percent_Sett)
ggplot(percentmesi, aes(x=cover, y=percent_Maggio, color=cover)) + geom_bar(stat="identity", fill="white")
ggplot(percentmesi, aes(x=cover, y=percent_Sett, color=cover)) + geom_bar(stat="identity", fill="white")
p2<-ggplot(percentmesi, aes(x=cover, y=percent_Sett, color=cover)) + geom_bar(stat="identity", fill="white")
p1<-ggplot(percentmesi, aes(x=cover, y=percent_Maggio, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1,p2,nrow=1)
pdf("Variazione campi coltivati vegetazione.pdf")
grid.arrange(p1,p2,nrow=1)
# campi coltivati in nettissima diminuzione nell'area nord dell'isola
# potrebbero essere stati gli incendi nell'area nord ad aver contribuito alla diminuzione così drastica dei campi coltivati, nonchè della vegetazione

# in ogni caso già le immagini satellitari relative al mese di settembre mostravano un cambiamento rispetto al mese di Maggio
# la vegetazione potrebbe anche aver risentito del caldo record oltre che degli incendi per cui comunque il tema del riscaldamento globale e del global warming rimane centrale
# occorre impegnarsi sempre di più per contrastare il riscaldamento globale e salvaguardare il nostro pianeta








