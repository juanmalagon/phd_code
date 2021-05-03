setwd("C:/Users/Juan/Desktop/dane/educacion_formal_2018")

require(ggplot2)
require(dplyr)

##################################
# 2018
##################################
#### Module I
##################################

VW_MODULOI_CARATURAUNICA <- read.csv('Carátula única sede educativa.csv',
                                     header = TRUE, 
                                     sep=';',
                                     encoding = 'UTF-8')

summary(VW_MODULOI_CARATURAUNICA)

ggplot(VW_MODULOI_CARATURAUNICA, 
       aes(DEPTO)) + 
  geom_bar(alpha = 0.2) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

ggplot(VW_MODULOI_CARATURAUNICA, 
       aes(fill=AREA_NOMBRE, DEPTO)) + 
  geom_bar(alpha = 0.2) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

ggplot(VW_MODULOI_CARATURAUNICA, 
       aes(fill=SECTOR_NOMBRE, DEPTO)) + 
  geom_bar(alpha = 0.2) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

####

VW_MODULOI_CARACTER <- read.csv('Caracter de la sede educativa.csv',
                                     header = TRUE, 
                                     sep=';',
                                     encoding = 'UTF-8')

summary(VW_MODULOI_CARACTER)

ggplot(VW_MODULOI_CARACTER, 
       aes(CARACTER_NOMBRE)) + 
  geom_bar(alpha = 0.2) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

####

VW_MODULOI_ESPECIALIDAD <- read.csv('Carácter y especialidad ofrecido por la sede educativa.csv',
                                    header = TRUE, 
                                    sep=';',
                                    encoding = 'UTF-8')

summary(VW_MODULOI_ESPECIALIDAD)

##################################
#### Module III
##################################

VW_MODULOIII_DOCENTESCARA_MOD <- read.csv('Docentes ocupados  en CLEI (mayor asignación académica).csv',
                                    header = TRUE, 
                                    sep=';',
                                    encoding = 'UTF-8')

summary(VW_MODULOIII_DOCENTESCARA_MOD)

#### 

VW_MODULOIII_DOCENTESCARA_TRA <- read.csv('Docentes ocupados según carácter por nivel educativo (educación tradicional) con mayor asignación académica.csv',
                                          header = TRUE, 
                                          sep=';',
                                          encoding = 'UTF-8')

summary(VW_MODULOIII_DOCENTESCARA_TRA)

ggplot(VW_MODULOIII_DOCENTESCARA_TRA, 
       aes(fill=NIVELENSE_NOMBRE, ESPECIALIDAD_NOMBRE)) + 
  geom_bar(alpha = 0.2) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

#### 

VW_MODULOIII_DOCENTESESCALFO <- read.csv('Docentes escalafonados según estatuto docente.csv',
                                          header = TRUE, 
                                          sep=';',
                                          encoding = 'UTF-8')

summary(VW_MODULOIII_DOCENTESESCALFO)

ggplot(VW_MODULOIII_DOCENTESESCALFO, 
       aes(GRADOESCA_NOMBRE)) + 
  geom_bar(alpha = 0.2) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

#### 

VW_MODULOIII_DOCENTESNIVELEDU <- read.csv('Máximo nivel educativo alcanzado por los docentes según rangos de edad por nivel educativo.csv',
                                         header = TRUE, 
                                         sep=';',
                                         encoding = 'UTF-8')

summary(VW_MODULOIII_DOCENTESNIVELEDU)

ggplot(VW_MODULOIII_DOCENTESNIVELEDU, 
       aes(fill=RANDOC_NOMBRE, NIVELEDUCDOC_NOMBRE)) + 
  geom_bar(alpha = 0.2) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

#### 

VW_MODULOIII_DOCENTESOCUPADOS <- read.csv('Docentes ocupados en la sede educativa según escalafón y tipo de vinculación laboral.csv',
                                          header = TRUE, 
                                          sep=';',
                                          encoding = 'UTF-8')

summary(VW_MODULOIII_DOCENTESOCUPADOS)

ggplot(VW_MODULOIII_DOCENTESOCUPADOS, 
       aes(VINCULA_NOMBRE)) + 
  geom_bar(alpha = 0.2) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

#### 

VW_MODULOIII_PERSONALOCUPADO <- read.csv('Personal ocupado en la sede educativa.csv',
                                          header = TRUE, 
                                          sep=';',
                                          encoding = 'UTF-8')

summary(VW_MODULOIII_PERSONALOCUPADO)

ggplot(VW_MODULOIII_PERSONALOCUPADO, 
       aes(CATEGORIA_NOMBRE)) + 
  geom_bar(alpha = 0.2) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))


##################################
#### Module VIII
##################################

VW_MODULOVIII_EQUIPOSCOMPUTO <- read.csv('Tenencia y número de equipos de cómputo por sede educativa.csv',
                                         header = TRUE, 
                                         sep=';',
                                         encoding = 'UTF-8')

summary(VW_MODULOVIII_EQUIPOSCOMPUTO)

ggplot(VW_MODULOVIII_EQUIPOSCOMPUTO, 
       aes(EQUIPOCOM_NOMBRE)) + 
  geom_bar(alpha = 0.2) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

#### 

VW_MODULOVIII_TECNOLOGIAS <- read.csv('Tenencia, acceso y uso de  bienes  y servicios TIC por sede educativa.csv',
                                         header = TRUE, 
                                         sep=';',
                                         encoding = 'UTF-8')

summary(VW_MODULOVIII_TECNOLOGIAS)

ggplot(VW_MODULOIII_PERSONALOCUPADO, 
       aes(CATEGORIA_NOMBRE)) + 
  geom_bar(alpha = 0.2) +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))
