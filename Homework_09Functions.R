#27 Mar 2024
#Functions list for Homework 09
#EPR


library(dplyr)
library(ggplot2)

nName<-c("Names","places")
nSize<-c(15,27)
nMean<-c(2,55)
nSD<-c(3,33)
############################################################
FakeDataGeneration<-function(Names=nName,Size=nSize,Mean=nMean,SD=nSD){

SoilMoisture<- data_frame(Index= 1:sum(nSize))
TNames<-rep(Names, times=Size)
SoilMoisture$Treatment<-TNames
SoilMoisture$Value<- NA
startIndex<-1
for (i in seq_along(Names)) {
  endIndex <- startIndex + Size[i] - 1
  SoilMoisture$Value[startIndex:endIndex]<-rnorm(n=Size[i], mean = Mean[i], sd=SD[i])
startIndex<-endIndex + 1
  } 
return(SoilMoisture)
}
############################################################

############################################################

AnoStats<-function(Data=FakeDataGeneration()){
  
  
  ANOModel<-aov(Value~Treatment, data=Data)
  z<-summary(ANOModel)
  
  ANOsum<-list(AverageofTreatments=aggregate(Value~Treatment, data=Data, FUN=mean),Fval=unlist(z)[7],probF=unlist(z)[9])
  
 
  
  return(ANOsum)

  
}

AnoStats()
#############################################################################


AnoPlot<-function(data){
    Plot<- ggplot(data=data,
                  aes(x=Treatment, y=Value,fill=Treatment))+
      geom_boxplot()
    return(Plot)
}
AnoPlot(data=FakeDataGeneration())
