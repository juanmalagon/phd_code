require(ggplot2)
require(dplyr)
require(tidyr)

##################################
# Module III
##################################
#### 2018
##################################

setwd("C:/Users/Juan/Desktop/dane/educacion_formal_2018")

VW_MODULOIII_DOCENTESESCALFO_2018 <- read.csv('Docentes escalafonados según estatuto docente.csv',
                                         header = TRUE, 
                                         sep=';',
                                         encoding = 'UTF-8')

summary(VW_MODULOIII_DOCENTESESCALFO_2018)

##################################
#### 2017
##################################

setwd("C:/Users/Juan/Desktop/dane/educacion_formal_2017")

VW_MODULOIII_DOCENTESESCALFO_2017 <- read.csv('Docentes escalafonados según estatuto docente.csv',
                                         header = TRUE, 
                                         sep=';',
                                         encoding = 'UTF-8')

summary(VW_MODULOIII_DOCENTESESCALFO_2017)

##################################
#### 2016
##################################

setwd("C:/Users/Juan/Desktop/dane/educacion_formal_2016")

VW_MODULOIII_DOCENTESESCALFO_2016 <- read.table('Docentes escalafonados según estatuto docente.txt',
                                         header = TRUE, 
                                         sep='\t',
                                         encoding = 'UTF-8')

summary(VW_MODULOIII_DOCENTESESCALFO_2016)

##################################
#### 2015
##################################

setwd("C:/Users/Juan/Desktop/dane/educacion_formal_2015")

VW_MODULOIII_DOCENTESESCALFO_2015 <- read.csv('Docentes escalafonados según estatuto docente.csv',
                                         header = TRUE, 
                                         sep=',',
                                         encoding = 'UTF-8')

summary(VW_MODULOIII_DOCENTESESCALFO_2015)

##################################
#### 2014
##################################

setwd("C:/Users/Juan/Desktop/dane/educacion_formal_2014")

VW_MODULOIII_DOCENTESESCALFO_2014 <- read.csv('Docentes escalafonados según estatuto docente.csv',
                                         header = TRUE, 
                                         sep=',',
                                         encoding = 'UTF-8')

summary(VW_MODULOIII_DOCENTESESCALFO_2014)

##################################
#### Prepare export
##################################

VW_MODULOIII_DOCENTESESCALFO.list <- list(VW_MODULOIII_DOCENTESESCALFO_2014,
                                          VW_MODULOIII_DOCENTESESCALFO_2015,
                                          VW_MODULOIII_DOCENTESESCALFO_2016,
                                          VW_MODULOIII_DOCENTESESCALFO_2017,
                                          VW_MODULOIII_DOCENTESESCALFO_2018)

VW_MODULOIII_DOCENTESESCALFO <- do.call("rbind", VW_MODULOIII_DOCENTESESCALFO.list)

remove(VW_MODULOIII_DOCENTESESCALFO.list)

# rm(list = c("sb11.2018",
#             "sb11.2017",
#             "sb11.2016",
#             "sb11.2015",
#             "sb11.20142"))

summary(VW_MODULOIII_DOCENTESESCALFO)

VW_MODULOIII_DOCENTESESCALFO$GRADOESCA_CODIGO <- as.factor(VW_MODULOIII_DOCENTESESCALFO$GRADOESCA_CODIGO)
VW_MODULOIII_DOCENTESESCALFO$GRADOESCA_NOMBRE <- as.factor(VW_MODULOIII_DOCENTESESCALFO$GRADOESCA_NOMBRE)


convertToUTF16 <- function(s){
  lapply(s, function(x) unlist(iconv(x,from="UTF-8",to="UTF-16LE",toRaw=TRUE)))
}

VW_MODULOIII_DOCENTESESCALFO$GRADOESCA_NOMBRE <- convertToUTF16(VW_MODULOIII_DOCENTESESCALFO$GRADOESCA_NOMBRE)


temp <- VW_MODULOIII_DOCENTESESCALFO %>%
  filter(PERIODO_ANIO==2018) %>%
  pivot_wider(names_from = )


library("odbc")





dbWriteTable(conn = con, name = SQL("phd.dbo.VW_MODULOIII_DOCENTESESCALFO"), 
             VW_MODULOIII_DOCENTESESCALFO, field.types = c(GRADOESCA_NOMBRE = "NVARCHAR(MAX)"),
             overwrite=TRUE)

