

dmuEfficiency1VRS = function(year, dataFrameYearYear){
      mainTitle = paste("Year ", year, sep = " ")

      Acronyms <- c("BUAP","COLMEX","IPN","ITSON","UAAAN","UABJO","CHAPINGO","UAA","UABC","UABCS",
                     "UACAM","UNACH","UACH","UACJ","UAC","UAGro","UNACAR","UAEH","UAEM","UAEMo",
                    "UAN","UANL","UAQ","UASLP","UAS","UAT","UATX","UADY","UAZ","UAM","UdeC",
                    "UDG","UG","UQROO","UNISON","UJAT","UJED","UMSNH","UNAM","UV")

      allEficiencies = data.frame( dataFrameYearYear[,"Number"],dataFrameYearYear[,"DMU"],vrsAnalysisA[,year],vrsAnalysisB[,year],vrsAnalysisC[,year]) 
      colnames(allEficiencies) <- c("NumberDMU","DMU", "effA","effB","effC")

      As <- subset(allEficiencies, effA==1)
      DMUA <- As$NumberDMU
      Bs <- subset(allEficiencies, effB==1)
      DMUB <- Bs$NumberDMU
      Cs <- subset(allEficiencies, effC==1)
      DMUC <- Cs$NumberDMU
      None <- subset(allEficiencies, effA != 1 & effB != 1 & effC != 1 )
      DMUNone <- None$NumberDMU

      temp <-  data.frame(Exercise=c(rep(1, 40)), Name=c(seq(1, 40, by = 1)), Score=c(seq(1, 40, by = 10)))
      temp2 <- data.frame(Name=c(rep(40,length(DMUNone))), Score=DMUNone)
      temp3 <- data.frame(Name=c(rep(30,length(DMUC))), Score=DMUC)
      temp4 <- data.frame(Name=c(rep(20,length(DMUB))), Score=DMUB)
      temp5 <- data.frame(Name=c(rep(10,length(DMUA))), Score=DMUA)
      
      classification <- ggplot() +
                        geom_bar(data=temp, aes(x = factor(Name), y=Score, fill = factor(Exercise)), width = 1, stat='identity') + 
                        geom_point(data=temp2, aes(x=Name, y=Score), color="black",size=2.5,shape=19) + 
                        geom_point(data=temp3, aes(x=Name, y=Score), color="black",size=2.5, shape=15) +
                        geom_point(data=temp4, aes(x=Name, y=Score), color="black",size=2.5, shape= 17) +
                        geom_point(data=temp5, aes(x=Name, y=Score), color="black",size=3.5, shape=18) +
                        coord_polar(theta = "y", start=0) + 
                        ylab("") + xlab("Model") + ggtitle(mainTitle) +
                        scale_y_continuous(breaks = c(seq(1, 40, by = 1)),labels = Acronyms) +
                        scale_x_discrete(breaks = seq(0,40, by = 10),labels=c("","A","B","C","None")) +
                        scale_fill_manual(values = c("transparent", "transparent", "transparent", "transparent")) +
                        theme(
                              legend.position = "none",
                              panel.grid.major = element_line(colour = "grey85"),
                              panel.background = element_rect(fill = "white"),
                              text=element_text(size=14, family="Times")
                      )
      print(classification)

}

dmuEfficiency1CRS = function(year, dataFrameYearYear){
  mainTitle = paste("Year ", year, sep = " ")
  
  Acronyms <- c("BUAP","COLMEX","IPN","ITSON","UAAAN","UABJO","CHAPINGO","UAA","UABC","UABCS",
                "UACAM","UNACH","UACH","UACJ","UAC","UAGro","UNACAR","UAEH","UAEM","UAEMo",
                "UAN","UANL","UAQ","UASLP","UAS","UAT","UATX","UADY","UAZ","UAM","UdeC",
                "UDG","UG","UQROO","UNISON","UJAT","UJED","UMSNH","UNAM","UV")
  
  allEficiencies = data.frame( dataFrameYearYear[,"Number"],dataFrameYearYear[,"DMU"],crsAnalysisA[,year],crsAnalysisB[,year],crsAnalysisC[,year]) 
  colnames(allEficiencies) <- c("NumberDMU","DMU", "effA","effB","effC")
  
  As <- subset(allEficiencies, effA==1)
  DMUA <- As$NumberDMU
  Bs <- subset(allEficiencies, effB==1)
  DMUB <- Bs$NumberDMU
  Cs <- subset(allEficiencies, effC==1)
  DMUC <- Cs$NumberDMU
  None <- subset(allEficiencies, effA != 1 & effB != 1 & effC != 1 )
  DMUNone <- None$NumberDMU
  
  temp <-  data.frame(Exercise=c(rep(1, 40)), Name=c(seq(1, 40, by = 1)), Score=c(seq(1, 40, by = 10)))
  temp2 <- data.frame(Name=c(rep(40,length(DMUNone))), Score=DMUNone)
  temp3 <- data.frame(Name=c(rep(30,length(DMUC))), Score=DMUC)
  temp4 <- data.frame(Name=c(rep(20,length(DMUB))), Score=DMUB)
  temp5 <- data.frame(Name=c(rep(10,length(DMUA))), Score=DMUA)
  
  classification <- ggplot() +
            geom_bar(data=temp, aes(x = factor(Name), y=Score, fill = factor(Exercise)), width = 1, stat='identity') + 
            geom_point(data=temp2, aes(x=Name, y=Score), color="black",size=3, shape=18) + 
            geom_point(data=temp3, aes(x=Name, y=Score), color="black",size=2.5, shape=4) +
            geom_point(data=temp4, aes(x=Name, y=Score), color="black",size=2.5, shape= 3) +
            geom_point(data=temp5, aes(x=Name, y=Score), color="black",size=3.5, shape=1) +
            coord_polar(theta = "y", start=0) + 
            ylab("") + xlab("Model") + ggtitle(mainTitle) +
            scale_y_continuous(breaks = c(seq(1, 40, by = 1)),labels = Acronyms) +
            scale_x_discrete(breaks = seq(0,40, by = 10),labels=c("","A","B","C","None")) +
            scale_fill_manual(values = c("transparent", "transparent", "transparent", "transparent")) +
            theme(
              legend.position = "none",
              panel.grid.major = element_line(colour = "grey79"),
              panel.background = element_rect(fill = "white"),
              text=element_text(size=14, family="Times")
            )
  setEPS()
  postscript("2016Eff1.eps", family="Times")
  plot(classification)
  dev.off()
}

