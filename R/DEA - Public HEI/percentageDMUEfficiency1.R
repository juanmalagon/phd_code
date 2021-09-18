

plotPercentageDMUEf1 = function(dataByYears, efficiencies, Model){
  
  percentageDMUEff1 = c( length(which(efficiencies[,4] == 1)),
                         length(which(efficiencies[,5] == 1)),
                         length(which(efficiencies[,6] == 1)),
                         length(which(efficiencies[,7] == 1)),
                         length(which(efficiencies[,8] == 1)),
                         length(which(efficiencies[,9] == 1)),
                         length(which(efficiencies[,10] == 1)),
                         length(which(efficiencies[,11] == 1)),
                         length(which(efficiencies[,12] == 1))
                       )
  dataPerYearDMUEff1 = data.frame("Year" = dataByYears, 
                                  "NumberDMU" = percentageDMUEff1, 
                                  "Percentage" = percentageDMUEff1/nrow(efficiencies), 
                                  "Model" = Model
                                  )
  return(dataPerYearDMUEff1)
}