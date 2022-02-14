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

# ricordare
# funzione ggplot associata a grid.arrange
# funzione plotRGB associata a par

