

peersPerDMU = function(inputVectors, outputVector, dataFrameYear, Model, Year){
  
          x = subset(dataFrameYear, select = inputVectors)
          y = subset(dataFrameYear, select = outputVector)

          # --------------------- CARRYING OUT THE STUDY ---------------------------------
          # -------------- Variable Returns to Scale ---------------------------------------
          solveDEA <- dea(x,y,SLACK=TRUE,RTS="crs", ORIENTATION="out", DUAL=TRUE)
          #resultsVRS <- data.frame(eff(analysisVRS),analysisVRS$slack,analysisVRS$sx,analysisVRS$sy,lambda(analysisVRS))
          completeResults = data.frame(round(1/eff(solveDEA), digits = 2), solveDEA$slack,  peers(solveDEA, NAMES = FALSE))
          
          subsetDataFrameA = subset(completeResults, !( (completeResults[,1] == 1.00) & (completeResults[,2] == FALSE) ) )
          
          Acronyms <- c("BUAP","COLMEX","IPN","ITSON","UAAAN","UABJO","CHAPINGO","UAA","UABC","UABCS",
                        "UACAM","UNACH","UACH","UACJ","UAC","UAGro","UNACAR","UAEH","UAEM","UAEMo",
                        "UAN","UANL","UAQ","UASLP","UAS","UAT","UATX","UADY","UAZ","UAM","UdeC",
                        "UDG","UG","UQROO","UNISON","UJAT","UJED","UMSNH","UNAM","UV")
          
          numberOfTheRow = as.numeric(rownames(subsetDataFrameA[1,]))
          Acronyms[numberOfTheRow]
          
          listPairsA = data.frame()
          r = 0
          for (i in 1:nrow(subsetDataFrameA)){
            from = as.numeric(rownames(subsetDataFrameA[i,]))
            for (j in 3:(ncol(subsetDataFrameA))){
              if ( !(is.na(subsetDataFrameA[i,j])) ){
                r = r+1
                to = subsetDataFrameA[i,j]
                listPairsA[r,1] = from
                listPairsA[r,2] = to
              }
            }
          }
          listPairsA$DMU = Acronyms[listPairsA$V1]
          listPairsA$PeerDMU = Acronyms[listPairsA$V2]
          listPairsA[,5] = Model
          listPairsA[,6] = Year
          colnames(listPairsA) = c("NoDMU", "NoPeerDMU", "DMU", "PeerDMU", "Model", "Year")
          
          return(listPairsA)
}


peersPerDMUPlot = function(dataFrameAllPeersA, dataFrameAllPeersB, dataFrameAllPeersC, yearToStudy){
  
  listAllPeers = list(dataFrameAllPeersA, dataFrameAllPeersB, dataFrameAllPeersC)
  dataFrameAllPeers = rbindlist(listAllPeers)
  # Do the plot -----------------------------------------------------------------------------------
  testToGraph = subset(dataFrameAllPeers, Year == yearToStudy)
  Acronyms <- c("BUAP","COLMEX","IPN","ITSON","UAAAN","UABJO","CHAPINGO","UAA","UABC","UABCS",
                "UACAM","UNACH","UACH","UACJ","UAC","UAGro","UNACAR","UAEH","UAEM","UAEMo",
                "UAN","UANL","UAQ","UASLP","UAS","UAT","UATX","UADY","UAZ","UAM","UdeC",
                "UDG","UG","UQROO","UNISON","UJAT","UJED","UMSNH","UNAM","UV")
  
  plotAllPeers <-  ggplot(testToGraph,  aes(x=DMU, y=PeerDMU, shape=Model)) + 
              geom_point(size=2) +
              scale_shape_manual(values=c(1,3,4)) +
              xlim(Acronyms) + ylim(rev(Acronyms)) + ggtitle(yearToStudy ) +
              ylab("Public HEI of Reference") + xlab("Public HEI") + 
              theme(
                    axis.text.x  = element_text(angle=90, vjust=0.5,  size=9, hjust=1),
                    text=element_text(family="Times"),
                    panel.grid.major = element_line(colour = "grey85"),
                    panel.background = element_rect(fill = "white"),
                    legend.position="top"
              )
  
  setEPS()
  postscript("plotAllPeers.eps", family="Times")
  print(plotAllPeers)
  dev.off()
  #print(plotAllPeers)
}











