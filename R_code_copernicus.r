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

# R è key sensitive
# occhio alle virgole, agli spazi e alle minuscole/maiuscole
