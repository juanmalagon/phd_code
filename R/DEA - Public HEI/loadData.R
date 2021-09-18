library(xlsx)
library(plyr)
library(gdata)

listAllFiles = list.files("Data")
pathToFiles = paste("Data/", listAllFiles, sep = "")
nameAllDataFrames = substr( pathToFiles, 12, nchar(pathToFiles)-4 )

for (i in 1:length(pathToFiles)) {
  nameDataFrame = nameAllDataFrames[i]
  theDataFrame = data.frame(read.xls(pathToFiles[i], fileEncoding = "latin1", header = FALSE))
  theDataFrame <- theDataFrame[-c(1,2,3,4), -c(13,14) ]
  names(theDataFrame) = c("Number", "DMU","2007", "2008", "2009", "2010", "2011", "2012", "2013","2014","2015","2016")
  assign(nameDataFrame, theDataFrame)
}

numberDMU = data.frame("Number" = Students$Number,
                       "DMU" = as.character(Students$DMU)
                      )

for (year in c("2007","2008","2009","2010","2011","2012","2013","2014","2015","2016")){
      dataFrameName1 = paste("DataYear", year, sep="")
      tempDataFrameYear =  data.frame( numberDMU,
                                       "teachers" = as.integer(as.character(Teachers[,year])),
                                       "finance" = as.integer(as.character(PublicFinance[,year])),
                                       "researchers" = as.integer(as.character(Researchers[,year])),
                                       "alumni" = as.integer(as.character(Students[,year])),
                                       "underPrograms" = as.integer(as.character(UndergradAcreditedProCIEES[,year])) + as.integer(as.character(UndergradAcreditedProCOPAES1[,year])) + as.integer(as.character(UndergradAcreditedProCOPAES2[,year])),
                                       "publishedPapers" = as.integer(as.character(DocumentsISI[,year])) + as.integer(as.character(DocumentsSCOPUS[,year])) + as.integer(as.character(PapersISI[,year])) + as.integer(as.character(PapersSCOPUS[,year])),
                                       "grantedPatents" = as.integer(as.character(GrantedPatents[,year])),
                                       "postgradPrograms" = as.integer(as.character(PosgradAccredProg[,year])),
                                       "editedJournals" = as.integer(as.character(CONACYTIndex[,year])) + as.integer(as.character(JournalsLatindex[,year])),
                                       "cites" = as.integer(as.character(CitesJournalsISI[,year])) + as.integer(as.character(CitesJournalsSCOPUS[,year])) + as.integer(as.character(CitesDocumentsISI[,year])) + as.integer(as.character(CitesDocumentsSCOPUS[,year]))
                                      )
      assign(dataFrameName1, tempDataFrameYear)
}


