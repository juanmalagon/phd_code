library(Benchmarking)

deaAnalysis <- function(dataFrameYear, inputVectors, outputVector){

        x = subset(dataFrameYear, select = inputVectors)
        y = subset(dataFrameYear, select = outputVector)

        # --------------------- CARRYING OUT THE STUDY ---------------------------------
        # -------------- Variable Returns to Scale ---------------------------------------
        analysisVRS <- dea(x,y,SLACK=TRUE,RTS="vrs", ORIENTATION="out", DUAL=TRUE)
        resultsVRS <- data.frame(eff(analysisVRS),analysisVRS$slack,analysisVRS$sx,analysisVRS$sy,lambda(analysisVRS))
        # -------------- Constant Returns to Scale --------------------------------------
        analysisCRS <- dea(x,y,SLACK=TRUE,RTS="crs", ORIENTATION="out", DUAL=TRUE)
        resultsCRS <- data.frame(eff(analysisCRS),analysisCRS$slack,analysisCRS$sx,analysisCRS$sy,lambda(analysisCRS))
        
        return(list(resultsVRS,resultsCRS))
}

