library(xlsx)

sumOfLambdas = function(inputVectors, outputVector, dataFrameYear, Model, Year){
  
         Acronyms <- c("BUAP","COLMEX","IPN","ITSON","UAAAN","UABJO","CHAPINGO","UAA","UABC","UABCS",
                        "UACAM","UNACH","UACH","UACJ","UAC","UAGro","UNACAR","UAEH","UAEM","UAEMo",
                        "UAN","UANL","UAQ","UASLP","UAS","UAT","UATX","UADY","UAZ","UAM","UdeC",
                        "UDG","UG","UQROO","UNISON","UJAT","UJED","UMSNH","UNAM","UV")
  
        x = subset(dataFrameYear, select = inputVectors)
        y = subset(dataFrameYear, select = outputVector)
  
        # --------------------- CARRYING OUT THE STUDY ---------------------------------
        # -------------- Variable Returns to Scale ---------------------------------------
        solveDEA <- dea(x,y,SLACK = TRUE, RTS = "crs", ORIENTATION = "out", DUAL=TRUE)
        muValues = data.frame(lambda(solveDEA))
        lambdaValues = data.frame((1/eff(solveDEA))*muValues)
        #lambdasName = data.frame((1/eff(solveDEA)), Acronyms)
        nameOfTheXlsxFile = paste(Model, "Lambdas2016.xlsx", sep ="")
        write.xlsx(lambdaValues, nameOfTheXlsxFile)
        #write.xlsx(lambdasName, 'eff2016.xlsx')
      
        dFLambdasModelYear = data.frame(rowSums(lambdaValues), Model, Year, Acronyms)
        colnames(dFLambdasModelYear) = c("SumLambdas", "Model", "Year", "Name")
        
  return(dFLambdasModelYear)
}

