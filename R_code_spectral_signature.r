#R_code_spectral_signature.r

# ogni oggetto, geologico o biologico, ha una propria firma spettrale 
library(raster)
# il pacchetto rgdal servirà per la funzione click
library(rgdal)
library(ggplot2)

setwd("C:/lab/")
defor2 <- brick("defor2.jpg")
# defor 2.1 , defor 2.2 , defor 2.3
# NIR, red , green
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

# funzione click
# click serve per "fare un click" all'interno dell'immagine per la firma spettrale 
# fa parte del pacchetto raster
# serve a cliccare sulla mappa e chiedere qualsiasi tipo di informazioni
# necessita del pacchetto rgdal
# id è l'identificazione
# id T=true o F=false
# xy sono le coordinate e i punti coordinate x e y
# type è il punto, ovvero p
# pch è il simbolo
# 16 corrisponde al pallino
# cex è l'esagerazione 
# con col scelgo il colore

click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="orange")

#results

#punto nella vegetazione
# alta riflettanza nell'infrarosso
#      x     y   cell defor2.1 defor2.2 defor2.3
# 1 143.5 253.5 160752      183       11       25


# punto nel fiume
# più bassa riflettanza nell'infrarosso, più alta nel rosso e ancora più alta nel verde (rispetto al punto precedente nella vegetazione)
# se avessimo la banda del blu avremmo un valore di riflettanza ancora più alto

#  x    y   cell defor2.1 defor2.2 defor2.3
# 1 368.5 95.5 274263      170       43       88


# defines the colums of the dataset
band <- c(1,2,3)
forest <- c(183,11,25)
water <- c(170,43,88)

# funzione data.frame per creare la tabella 
spectrals <- data.frame(band,forest,water)

ggplot(spectrals, aes(x=band)) + geom_line(aes(y=forest), color="green") + geom_line(aes(y=water), color="blue")
# ottengo un grafico dove sull'asse x ho le bande e sull'asse y ho i valori di riflettanza
# linea verde per la vegetazione
# linea blu per l'acqua
# dovrei vedere un comportamento diametralmente opposto dell'acqua rispetto alla vegetazione
# l'acqua ha un valore di riflettanza nell'infrarosso molto basso, assorbe un pò di più nel rosso e ha valori di riflettanza più alti nel blu 
# aggiungo la funzione labs
# aggiungo i titoli negli assi
ggplot(spectrals, aes(x=band)) + geom_line(aes(y=forest), color="green") + geom_line(aes(y=water), color="blue")+labs(x="band", y="reflectance")

################### multitemporal

defor1 <- brick("defor1.jpg")
plotRGB(defor1, r=1,b=2,g=3, stretch="lin")
# spectral signature defor1
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="orange")

# 5 punti cliccati sulla mappa dove è evidente la deforestazione


#    x     y   cell defor1.1 defor1.2 defor1.3
# 1 43.5 333.5 102860      194       10       22
#      x     y   cell defor1.1 defor1.2 defor1.3
# 1 73.5 324.5 109316      212       11       29
#      x     y   cell defor1.1 defor1.2 defor1.3
# 1 91.5 330.5 105050      215       17       34
#      x     y  cell defor1.1 defor1.2 defor1.3
# # 1 85.5 379.5 70058      229       17       39
#      x     y  cell defor1.1 defor1.2 defor1.3
# 1 77.5 399.5 55770      216       30       54

# tempo2
plotRGB(defor2, r=1,b=2,g=3, stretch="lin")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="orange")

#    x     y   cell defor2.1 defor2.2 defor2.3
# 1 59.5 337.5 100440      170      182      168
#     x     y   cell defor2.1 defor2.2 defor2.3
# 1 84.5 329.5 106201      161      133      130
#      x     y  cell defor2.1 defor2.2 defor2.3
# 1 101.5 341.5 97614      168      151      141
#     x     y  cell defor2.1 defor2.2 defor2.3
# 1 88.5 372.5 75374      214       13       29
#     x     y  cell defor2.1 defor2.2 defor2.3
# 1 76.5 395.5 58871      209       14       28

# define the colums of the dataset:
band <- c(1,2,3)
time1 <- c(194,10,22)
time2 <- c(170,182,168)
# facciamo il data frame di spectrals ma nell'analisi temporale
# nuovo oggetto spectralst
spectralst <- data.frame(band,time1,time2)

ggplot(spectrals, aes(x=band)) + geom_line(aes(y=time1), color="red") + geom_line(aes(y=time2), color="yellow")
# posso cambiare le caratteristiche della linea utilizzando linetype
# linetype="dotted" per una linea punteggiata anzichè continua
# posso anche lavorare con 2 pixel
# es. time1p2 e time2p2 ottenendo una tabella ancora più completa con 12 valori totali anzichè 6 (sempre con le tre bande sull'asse x)

# image from Earth observatory 
eo <- brick("Santorini.jpg")
plotRGB(eo, r=1,g=2,b=3, stretch="hist")

click(eo, id=T, xy=T, cell=T, type="p", pch=16, cex=4, col="orange")

#     x    y   cell Santorini.1 Santorini.2 Santorini.3
#  1 493.5 75.5 139814          21          67          90
#      x    y   cell Santorini.1 Santorini.2 Santorini.3
# 1 24.5 91.5 130705           0          43          90
#         x    y   cell Santorini.1 Santorini.2 Santorini.3
# 1 45.5 46.5 155026          56          85         101

# define the colums of the dataset:
band <- c(1,2,3)
stratum1 <- c(21,67,90)
stratum2 <- c(0,43,90)
stratum3 <- c(56, 85,101)

spectralsg <- data.frame(band,stratum1,stratum2,stratum3)

ggplot(spectrals, aes(x=band)) + geom_line(aes(y=stratum1), color="yellow") + geom_line(aes(y=stratum2), color="green")+geom_line(aes(y=stratum3), color="blue")+ labs(x="band",y="reflectance")

# nel mio caso vedo che le linee hanno tutte lo stesso andamento 
# i valori tendono ad aumentare dalla banda 1 alla banda 3 
# non vedo una grande differenziazione 

dev.off()




