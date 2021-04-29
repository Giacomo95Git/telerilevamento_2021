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
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4 ,g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res , r=4 ,g=3, b=2, stretch="lin")


p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

summary(p224r63_2011res_pca$model)
plot(p224r63_2011res_pca$map)
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")
