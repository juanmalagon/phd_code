library("ggplot2")
library("reshape2")
#---------------------------------------------------------------------------------------------------
#### Function to compute Variable Returns to Scale -------------------------------------------------
#---------------------------------------------------------------------------------------------------
plotEfficienciesByYearVRS = function(dataYear, inputVector, outputVector){
  
  
  Acronyms <- c("BUAP","COLMEX","IPN","ITSON","UAAAN","UABJO","CHAPINGO","UAA","UABC","UABCS",
                "UACAM","UNACH","UACH","UACJ","UAC","UAGro","UNACAR","UAEH","UAEM","UAEMo",
                "UAN","UANL","UAQ","UASLP","UAS","UAT","UATX","UADY","UAZ","UAM","UdeC",
                "UDG","UG","UQROO","UNISON","UJAT","UJED","UMSNH","UNAM","UV")
  allEficienciesByYearVRS = subset(dataYear[[1]], select = c("Number","DMU"))
  allEficienciesByYearVRS$Acronyms = Acronyms
  
  for(i in 1:length(dataYear)){
    columnName = paste("vrsYear", as.character(i), sep="")
    results = deaAnalysis(dataYear[[i]],inputVector,outputVector)
    variableReturnToScale = data.frame(results[1])
    allEficienciesByYearVRS[,columnName] = round(1/variableReturnToScale$eff.analysisVRS., digits = 2)
  }
  
  names(allEficienciesByYearVRS) <- c("Number","DMU","Acronyms", "2008", "2009", "2010", "2011", "2012", "2013","2014","2015","2016")
   
  sdf1 = allEficienciesByYearVRS[,-c(1,2)]
  sdf2 = melt(sdf1, id.vars=c("Acronyms"),var='year')
  names(sdf2) = c("Acronyms", "year", "Efficiency")
  graphBubble = ggplot(sdf2, 
                aes(x = Acronyms, y = year, size = Efficiency, color = Efficiency )) +
                geom_point() + scale_colour_gradient(low = "black", high = "grey") + 
                theme_light() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                geom_text(aes(label=Efficiency),vjust = 0, nudge_y = 0.2, angle = 45, size=3.5) +
                xlab("Public HEI") + ylab("Year") + ggtitle("Efficiency with Variable Returns of Scale")
  plot(graphBubble)
  return(allEficienciesByYearVRS)
}


#---------------------------------------------------------------------------------------------------
#### Function to compute Constant Returns to Scale -------------------------------------------------
#---------------------------------------------------------------------------------------------------
plotEfficienciesByYearCRS = function(dataYear, inputVector, outputVector){
  
  
  Acronyms <- c("BUAP","COLMEX","IPN","ITSON","UAAAN","UABJO","CHAPINGO","UAA","UABC","UABCS",
                "UACAM","UNACH","UACH","UACJ","UAC","UAGro","UNACAR","UAEH","UAEM","UAEMo",
                "UAN","UANL","UAQ","UASLP","UAS","UAT","UATX","UADY","UAZ","UAM","UdeC",
                "UDG","UG","UQROO","UNISON","UJAT","UJED","UMSNH","UNAM","UV")
  allEficienciesByYearCRS = subset(dataYear[[1]], select = c("Number","DMU"))
  allEficienciesByYearCRS$Acronyms = Acronyms
  
  for(i in 1:length(dataYear)){
    columnName = paste("crsYear", as.character(i), sep="")
    results = deaAnalysis(dataYear[[i]],inputVector,outputVector)
    constantReturnToScale = data.frame(results[2])
    allEficienciesByYearCRS[,columnName] = round(1/constantReturnToScale$eff.analysisCRS., digits = 2)
  }
  
  names(allEficienciesByYearCRS) <- c("Number","DMU","Acronyms", "2008", "2009", "2010", "2011", "2012", "2013","2014","2015","2016")
  #aes(x = Acronyms, y = year, size = Efficiency, color = Efficiency )) +
  sdf11 = allEficienciesByYearCRS[,-c(1,2)]
  sdf22 = melt(sdf11, id.vars=c("Acronyms"),var='year')
  names(sdf22) = c("Acronyms", "year", "Efficiency")
  graphBubble1 = ggplot(sdf22, aes(x = Acronyms, y = year, size = Efficiency )) +
                      geom_point() + scale_colour_gradient(low = "black", high = "grey") + 
                      theme_light() + theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                      geom_text(aes(label=Efficiency),vjust = 0, nudge_y = 0.2, angle = 45, size=3.5) +
                      xlab("Public HEI") + ylab("Year") + ggtitle("Efficiency with Constant Returns of Scale")
  #postscript("knowledgeYears.eps", width = 480, height = 300)
  plot(graphBubble1)
  #dev.off()
  return(allEficienciesByYearCRS)
}



