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
