
tableImprovements = function(xA, yA, Model){
  
  Acronyms <- c("BUAP","COLMEX","IPN","ITSON","UAAAN","UABJO","CHAPINGO","UAA","UABC","UABCS",
                "UACAM","UNACH","UACH","UACJ","UAC","UAGro","UNACAR","UAEH","UAEM","UAEMo",
                "UAN","UANL","UAQ","UASLP","UAS","UAT","UATX","UADY","UAZ","UAM","UdeC",
                "UDG","UG","UQROO","UNISON","UJAT","UJED","UMSNH","UNAM","UV")
  
  modelAOut = dea(xA,yA,SLACK=TRUE,RTS="crs", ORIENTATION="out", DUAL=TRUE)
  resultsModelAOut <- data.frame(DataYear2016$DMU, eff(modelAOut), xA, yA, modelAOut$slack,modelAOut$sx,modelAOut$sy,lambda(modelAOut))
  
  #fileName = paste("outputs", Model, ".xlsx", sep = "")
  #write.xlsx(resultsModelAOut, fileName)
  
  modelAOut = dea(xA,yA,SLACK=TRUE,RTS="crs", ORIENTATION="out", DUAL=TRUE)
  resultsModelAOut <- data.frame(DataYear2016$DMU, eff(modelAOut), xA, yA, modelAOut$slack,modelAOut$sx,modelAOut$sy,lambda(modelAOut))
  #write.xlsx(resultsModelAOut, "usarrests.xlsx")
  
  efficiencyDMU = data.frame(eff(modelAOut))
  slackDataSx = data.frame(modelAOut$slack, modelAOut$sx)
  slackDataSy = data.frame(modelAOut$slack, modelAOut$sy)
  lambdasAll = data.frame(lambda(modelAOut))
  
  # Complete the lambda's data.frame
  df0 <- as.data.frame(matrix(0, nrow=nrow(lambdasAll), ncol=nrow(lambdasAll)))
  names(df0) <- paste0("L", 1:nrow(lambdasAll))
  lambdasAllComplete <- cbind(lambdasAll, df0[ , -match(names(lambdasAll), names(df0))])
  allLambdasA = lambdasAllComplete[order(as.numeric(gsub("L", "", colnames(lambdasAllComplete))))]
  
  
  # Improvements in INPUTS - OUT ORIENTATION --------
  improvementsSx2 <- data.frame(matrix(NA, nrow = nrow(efficiencyDMU), ncol = ncol(xA)))
  for(a in 1:ncol(xA)){
    valuesSx2 = data.frame(xA[,a]) - data.frame(slackDataSx[,a+1])
    improvementsSx2[,a] = valuesSx2
  }
  
  improvementsSx1 <- data.frame()
  for(ia in 1:ncol(xA)){
    for(ja in 1:ncol(allLambdasA) ){
      improvementsSx1[ja,ia] = sum(xA[,ia]*allLambdasA[ja,])
    }
  }
  
  # Improvements in OUTPUTS - OUT ORIENTATION --------
  improvementsSy2 <- data.frame(matrix(NA, nrow = nrow(efficiencyDMU), ncol = ncol(yA)))
  for(ib in 1:ncol(yA)){
    valuesSy2 = efficiencyDMU*data.frame(yA[,ib]) + data.frame(slackDataSy[,ib+1])
    improvementsSy2[,ib] = valuesSy2
  }
  
  improvementsSy1 <- data.frame()
  for(ic in 1:ncol(yA)){
    for(jc in 1:ncol(allLambdasA) ){
      improvementsSy1[jc,ic] = sum(yA[,ic]*allLambdasA[jc,])
    }
  }
  #allImprovemnetsA = format(data.frame(Acronyms, improvementsSx2, improvementsSy2, improvementsSx1, improvementsSy1), digits = 1)
  allImprovemnetsA = data.frame(Acronyms, improvementsSx1, improvementsSy1)
  
  fileName = paste("allImprovements", Model, ".xlsx", sep = "")
  write.xlsx(allImprovemnetsA, fileName)
}