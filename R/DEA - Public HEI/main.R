library("data.table")
library("xlsx")
library("ggplot2")
library("reshape2")
library("latex2exp")
library("extrafont")
library("Benchmarking")
font_import()

source("loadData.R")
source("computeEfficiency.R")
source("graphEfficiency.R")
source("DMUEfficiency1.R")
source("peers.R")
source("sumOfLambdas.R")
source("percentageDMUEfficiency1.R")
source("improvements.R")

#**********************************************************************************************
# Year to be studied 
#**********************************************************************************************
dataFramesByYear = list(DataYear2008,DataYear2009,DataYear2010,DataYear2011,DataYear2012,DataYear2013,DataYear2014,DataYear2015,DataYear2016)
dataByYears = c("2008","2009","2010","2011","2012","2013","2014","2015","2016")
#**********************************************************************************************
# Model A: Teaching
#**********************************************************************************************
Model = "A"
inputVariablesA = c("teachers","finance","researchers")
outputVariablesA = c("alumni","underPrograms")

#vrsAnalysisA = plotEfficienciesByYearVRS(dataFramesByYear, inputVariablesA, outputVariablesA)
crsAnalysisA = plotEfficienciesByYearCRS(dataFramesByYear, inputVariablesA, outputVariablesA)
#rowMeans(crsAnalysisA[,4:12])
#colMeans(crsAnalysisA[,4:12])
#**********************************************************************************************
# Model B: Research
#**********************************************************************************************
Model = "B"
inputVariablesB = c("teachers","finance","researchers")
outputVariablesB = c("publishedPapers","grantedPatents", "postgradPrograms")

#vrsAnalysisB = plotEfficienciesByYearVRS(dataFramesByYear, inputVariablesB, outputVariablesB)
crsAnalysisB = plotEfficienciesByYearCRS(dataFramesByYear, inputVariablesB, outputVariablesB)
#rowMeans(crsAnalysisB[,4:12])
#colMeans(crsAnalysisB[,4:12])
#**********************************************************************************************
# Model C: Knowledge dessimination
#**********************************************************************************************
Model = "C"
inputVariablesC = c("teachers","finance","researchers")
outputVariablesC = c("editedJournals","cites")

#vrsAnalysisC = plotEfficienciesByYearVRS(dataFramesByYear, inputVariablesC, outputVariablesC)
crsAnalysisC = plotEfficienciesByYearCRS(dataFramesByYear, inputVariablesC, outputVariablesC)
#rowMeans(crsAnalysisC[,4:12])
#colMeans(crsAnalysisC[,4:12])


#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Plot perecentage of DMU with efficiency 1 per year
  
doThePlotModelB = plotPercentageDMUEf1(dataByYears,crsAnalysisB, "B")
doThePlotModelC = plotPercentageDMUEf1(dataByYears,crsAnalysisC, "C")
doThePlotModelA = plotPercentageDMUEf1(dataByYears,crsAnalysisA, "A")

doThePlotModels = do.call("rbind", list(doThePlotModelA, doThePlotModelB, doThePlotModelC))

percentageDMUEf1 = ggplot(doThePlotModels, aes(x = Year,y = Percentage, colour = Model, group = Model)) + 
                    geom_point(aes(shape = Model, size = Model)) + geom_line( aes(linetype = Model) ) +
                    scale_color_manual(values=c("black","black","black")) +
                    scale_size_manual(values=c(3,3,3))+
                    scale_shape_manual(values=c(1,3,4)) +
                    scale_linetype_manual(values=c("twodash", "dotted", "solid")) +
                    scale_y_continuous(breaks = pretty(doThePlotModels$Percentage, n = 12)) +
                    #scale_y_continuous(breaks = seq(min(doThePlotModels$Percentage), max(doThePlotModels$Percentage), by = 0.05)) +
                    ylab(TeX("Percentage  of P-HEI with $\\eta = 1$")) +
                    theme(
                          text = element_text(size=15),
                          axis.text.x  = element_text(angle=90, vjust=0.5, size=14),
                          axis.text.y = element_text(size=14),
                          panel.grid.major = element_line(colour = "grey85"),
                          panel.background = element_rect(fill = "white"),
                          legend.position="top"
                    )
#setEPS()
#postscript("percentageDMUEf1.eps", family="Times")
plot(percentageDMUEf1)
#dev.off()

#...................................................................................................

efficiencyPerYearA = data.frame("Year" = dataByYears, 
                                "Percentage" = colMeans(crsAnalysisA[,4:12]),
                                "Model" = "A")
efficiencyPerYearB = data.frame("Year" = dataByYears, 
                                "Percentage" = colMeans(crsAnalysisB[,4:12]),
                                "Model" = "B")
efficiencyPerYearC = data.frame("Year" = dataByYears, 
                                "Percentage" = colMeans(crsAnalysisC[,4:12]),
                                "Model" = "C")

doThePlotModelsEfficiencyPerYear = do.call("rbind", list(efficiencyPerYearA, efficiencyPerYearB, efficiencyPerYearC))

annualEfficiency = ggplot(doThePlotModelsEfficiencyPerYear, aes(x = Year,y = Percentage, colour = Model, group = Model)) + 
                    geom_point(aes(shape = Model, size = Model)) + geom_line( aes(linetype = Model) ) +
                    scale_color_manual(values=c("black","black","black")) +
                    scale_size_manual(values=c(3,3,3))+
                    scale_shape_manual(values=c(1,3,4)) +
                    scale_linetype_manual(values=c("twodash", "dotted", "solid")) +
                    scale_y_continuous(breaks = seq(0, 1, by = 0.02)) +
                    ylab("Average Efficiency") +
                    theme(
                            text = element_text(size=15, family="Times"),
                            axis.text.x  = element_text(angle=90, vjust=0.5, size=14),
                            axis.text.y = element_text(size=14),
                            panel.grid.major = element_line(colour = "grey85"),
                            panel.background = element_rect(fill = "white"),
                            legend.position="top"
                          )
#setEPS()
#postscript("annualEfficiency.eps", family="Times")
#annualEfficiency
#dev.off()

#**********************************************************************************************
# Plot the DMU with 100% efficiency in every models
#**********************************************************************************************
r = 0
for (year in dataByYears){
          r = r + 1
          dmuEfficiency1CRS(year, dataFramesByYear[[r]] )
          #dmuEfficiency1VRS(year, dataFramesByYear[[r]] )
}
#**********************************************************************************************
# Plot the Peers 
#**********************************************************************************************
# Prepare the data
#------------------------------------------------------------------------------------------------
# For model A -----------------------------------------------------------------------------------
dataFrameAllPeersA = data.frame()
Model = "A"
for (i in 1:length(dataFramesByYear)){
  listOfPeersA = peersPerDMU(inputVariablesA, outputVariablesA, dataFramesByYear[[i]], Model, dataByYears[i])
  dataFrameAllPeersA = rbind(dataFrameAllPeersA, listOfPeersA)
}
# For model B -----------------------------------------------------------------------------------
dataFrameAllPeersB = data.frame()
Model = "B"
for (i in 1:length(dataFramesByYear)){
  listOfPeersB = peersPerDMU(inputVariablesB, outputVariablesB, dataFramesByYear[[i]], Model, dataByYears[i])
  dataFrameAllPeersB = rbind(dataFrameAllPeersB, listOfPeersB)
}
# For model C -----------------------------------------------------------------------------------
dataFrameAllPeersC = data.frame()
Model = "C"
for (i in 1:length(dataFramesByYear)){
  listOfPeersC = peersPerDMU(inputVariablesC, outputVariablesC, dataFramesByYear[[i]], Model, dataByYears[i])
  dataFrameAllPeersC = rbind(dataFrameAllPeersC, listOfPeersC)
}
# -----------------------------------------------------------------------------------------------
# Do the plot -----------------------------------------------------------------------------------
yearToStudy = "2016"
peersPerDMUPlot(dataFrameAllPeersA, dataFrameAllPeersB, dataFrameAllPeersC, yearToStudy)

#**********************************************************************************************
# Plot of the sum of the lambdas
#**********************************************************************************************
#**********************************************************************************************
# Model A: Teaching
#**********************************************************************************************
# For model A ---------------------------------------------------------------------------------
dataFrameAllLambdasA = data.frame()
Model = "A"
for (i in 1:length(dataFramesByYear)){
  dataFrameLambdasA = sumOfLambdas(inputVariablesA, outputVariablesA, dataFramesByYear[[i]], Model, dataByYears[i])
  dataFrameAllLambdasA = rbind(dataFrameAllLambdasA, dataFrameLambdasA)
}
# For model B ---------------------------------------------------------------------------------
dataFrameAllLambdasB = data.frame()
Model = "B"
for (i in 1:length(dataFramesByYear)){
  dataFrameLambdasB = sumOfLambdas(inputVariablesB, outputVariablesB, dataFramesByYear[[i]], Model, dataByYears[i])
  dataFrameAllLambdasB = rbind(dataFrameAllLambdasB, dataFrameLambdasB)
}
# For model C ---------------------------------------------------------------------------------
dataFrameAllLambdasC = data.frame()
Model = "C"
for (i in 1:length(dataFramesByYear)){
  dataFrameLambdasC = sumOfLambdas(inputVariablesC, outputVariablesC, dataFramesByYear[[i]], Model, dataByYears[i])
  dataFrameAllLambdasC = rbind(dataFrameAllLambdasC, dataFrameLambdasC)
}

#Year to compute the graph
yearLambdas = 2016
lambdasModelA = subset(dataFrameAllLambdasA, Year == yearLambdas)
lambdasModelB = subset(dataFrameAllLambdasB, Year == yearLambdas)
lambdasModelC = subset(dataFrameAllLambdasC, Year == yearLambdas)

allLambdas <- do.call("rbind", list(lambdasModelA, lambdasModelB, lambdasModelC))

allLambdas = subset(allLambdas, SumLambdas < 7 )
maxValueLambda = max(allLambdas$SumLambdas, na.rm = TRUE)

ggplot(allLambdas, aes(x=Name, y=SumLambdas, group=Model)) +
  geom_point(aes(shape=Model, color=Model, size=Model)) +
  scale_y_continuous(breaks=seq(0,maxValueLambda,1)) +
  scale_shape_manual(values=c(1,3,4)) +
  scale_color_manual(values=c("black","black","black")) +
  scale_size_manual(values=c(2.5,2.5,2.5)) + 
  geom_hline(yintercept=1) +
  ylab(expression(~Sigma~lambda)) + xlab("DMU (Public HEI)") +
  theme(
    axis.text.x  = element_text(angle=90, vjust=0.5, size=9),
    text=element_text(family="Times"),
    panel.grid.major = element_line(colour = "grey85"),
    panel.background = element_rect(fill = "white")
  )
#----------------------------------------------------------------------------------------------
# Compute improvements ------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------
#**********************************************************************************************
# Model A: Teaching
#**********************************************************************************************
xA = subset(DataYear2016, select = inputVariablesA)
yA = subset(DataYear2016, select = outputVariablesA)
tableImprovements(xA, yA, "A")

#**********************************************************************************************
# Model B: Researching 
#**********************************************************************************************
xB = subset(DataYear2016, select = inputVariablesB)
yB = subset(DataYear2016, select = outputVariablesB)
tableImprovements(xB, yB, "B")

#**********************************************************************************************
# Model B: Knowledge Dissemination
#**********************************************************************************************
xC = subset(DataYear2016, select = inputVariablesC)
yC = subset(DataYear2016, select = outputVariablesC)
tableImprovements(xC, yC, "C")






