# piccolo pezzo di codice sul gran canyon per la classificazione
# classificazione della stessa immagine
# classificazione con la funzione unsuperClass
# sia con 2 classi che con 4 classi per apprezzare le differenze
# posso plottare anche solo la mappa di un oggetto tramite il comando $
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
# ricorda che R è key sensitive
# esempio unsuperclass non esiste perchè la C deve essere maiuscola 
# unsuperClass funzione giusta
# occhio sempre anche a parentesi, virgole, spazi ecc.
