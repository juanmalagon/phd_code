setwd("/Users/juanmalagon/Desktop/Malagon-Haelermans/ftpdbicfes/4. Saber11/4. Clasificación de Planteles")

require(ggplot2)
require(dplyr)

##################################
# 2018
sb11.20182 <- read.table('SB11-CLASIFI-PLANTELES-20182.txt', 
                 header = TRUE,
                 fileEncoding = 'UTF-8',
                 sep='¬',
                 quote = "",
                 comment.char = "",
                 strip.white = TRUE,
                 dec = ',')

sb11.20181 <- read.table('SB11-CLASIFI-PLANTELES-20181.txt', 
                         header = TRUE, 
                         sep='|',
                         fileEncoding = 'latin1',
                         quote = "",
                         comment.char = "",
                         strip.white = TRUE,
                         dec = '.')

sb11.2018 <- rbind(sb11.20181, sb11.20182)

remove(sb11.20181)
remove(sb11.20182)

summary(sb11.2018)

##################################
# Visualizations

ggplot(sb11.2018, 
       aes(INDICE_TOTAL)) + 
  geom_density(alpha = 0.2)

ggplot(sb11.2018, 
       aes(INDICE_TOTAL, 
           fill = COLE_NATURALEZA)) + 
  geom_histogram(alpha=0.2, bins = 100)

ggplot(sb11.2018, 
       aes(INDICE_TOTAL, 
           fill = COLE_NATURALEZA)) + 
  geom_density(alpha=0.2)

ggplot(sb11.2018, 
       aes(INDICE_TOTAL, 
           fill = COLE_DEPTO_COLEGIO)) + 
  geom_density(alpha=0.2)

depts <- sb11.2018 %>%
  group_by(COLE_DEPTO_COLEGIO) %>%
  summarise(MEAN_BY_DEPT = mean(INDICE_TOTAL),
            MEDIAN_BY_DEPT = median(INDICE_TOTAL))

temp <- sb11.2018 %>%
  group_by(COLE_DEPTO_COLEGIO) %>%
  mutate(MEAN_BY_DEPT = mean(INDICE_TOTAL)) %>%
  ungroup()

ggplot(temp[temp$MEAN_BY_DEPT>median(temp$INDICE_TOTAL),], 
       aes(INDICE_TOTAL, 
           fill = COLE_DEPTO_COLEGIO)) + 
  geom_density(alpha=0.2)


##################################
#2017

sb11.20172 <- read.csv('SB11-CLASIFI-PLANTELES-20172.csv', 
                         header = TRUE, 
                         sep=',',
                         fileEncoding = 'UTF-8',
                         quote = '"',
                         comment.char = "",
                         dec = '.')

sb11.20171 <- read.csv('SB11-CLASIFI-PLANTELES-20171.csv', 
                       header = TRUE, 
                       sep=',',
                       fileEncoding = 'UTF-8',
                       quote = '"',
                       comment.char = "",
                       dec = '.')

sb11.2017 <- rbind(sb11.20171, sb11.20172)
remove(sb11.20171)
remove(sb11.20172)

summary(sb11.2017)

##################################
#2016

sb11.20162 <- read.table('SB11-CLASIFI-PLANTELES-20162.txt', 
                         header = TRUE, 
                         sep='|',
                         fileEncoding = 'latin1',
                         quote = "",
                         comment.char = "",
                         dec = ',')

sb11.20161 <- read.table('SB11-CLASIFI-PLANTELES-20161.txt', 
                         header = TRUE, 
                         sep='|',
                         fileEncoding = 'latin1',
                         quote = "",
                         comment.char = "",
                         dec = ',')

sb11.2016 <- rbind(sb11.20161, sb11.20162)
remove(sb11.20161)
remove(sb11.20162)

##################################
#2015

sb11.20152 <- read.table('SB11-CLASIFI-PLANTELES-20152.txt', 
                         header = TRUE, 
                         sep='|',
                         fileEncoding = 'latin1',
                         quote = '"',
                         comment.char = "",
                         dec = ',')

sb11.20151 <- read.table('SB11-CLASIFI-PLANTELES-20151.txt', 
                         header = TRUE, 
                         sep='|',
                         fileEncoding = 'latin1',
                         quote = '"',
                         comment.char = "",
                         dec = ',')

sb11.2015 <- rbind(sb11.20151, sb11.20152)
remove(sb11.20151)
remove(sb11.20152)

summary(sb11.2015)

##################################
#2014

sb11.20142 <- read.table('SB11-CLASIFI-PLANTELES-20142.txt', 
                         header = TRUE, 
                         sep='|',
                         fileEncoding = 'latin1',
                         quote = '"',
                         comment.char = "",
                         dec = ',')

sb11.20141 <- read.table('SB11-CLASIFI-PLANTELES-20141.txt', 
                         header = TRUE, 
                         sep='\t',
                         fileEncoding = 'latin1',
                         quote = '',
                         comment.char = "",
                         dec = '.')

# sb11.2014 <- rbind(sb11.20141, sb11.20142)
# remove(sb11.20141)
# remove(sb11.20142)

summary(sb11.20142)
summary(sb11.20141)


##################################
# Merge dataframes

sb11.list <- list(sb11.2018,
               sb11.2017,
               sb11.2016,
               sb11.2015,
               sb11.20142)

sb11 <- do.call("rbind", sb11.list)

remove(sb11.list)
rm(list = c("sb11.2018",
         "sb11.2017",
         "sb11.2016",
         "sb11.2015",
         "sb11.20142"))

summary(sb11)

sb11$COLE_COD_DANE <- as.factor(sb11$COLE_COD_DANE)
sb11$COLE_CODMPIO_COLEGIO <- as.factor(sb11$COLE_CODMPIO_COLEGIO)
sb11$COLE_COD_DEPTO <- as.factor(sb11$COLE_COD_DEPTO)
sb11 <- transform(sb11,
                  YEAR = substr(PERIODO, 1, 4), 
                  PERIOD = substr(PERIODO, 5, 5))

sb11 <- sb11 %>% select(YEAR, PERIOD, everything())

library("odbc")

dbWriteTable(conn = con, name = SQL("phd.dbo.planteles_20142_20182"), sb11)
