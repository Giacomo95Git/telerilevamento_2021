#R_code_knitr.r

setwd("C:/lab/")
# la funzione require come la funzione library richiama il pacchetto scelto
# library o require è indifferente 
# il pacchetto knitr permette ad esempio l'integrazione del codice all'interno di un documento in LaTeX 
library(knitr)
# la funzione stitch crea automaticamente un report basato su uno script R e uno schema 
# lo script R è il file "R_code_greenland.r" 
# il pacchetto knitr è essenziale
# con stitch viene creato dentro R un report che poi verrà salvato nella cartella .r
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
# copio tutto il codice "time series"
