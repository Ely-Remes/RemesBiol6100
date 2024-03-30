#27 Mar 2024
#Functions list for Homework 09
#EPR


# Set up libraries
library(ggplot2)
library(dplyr)
#Set up global variables

nName<- c("Ambient","Drought") #Names of treatments
nSize <- c(30,30)
nMean <- c(0.103697, 0.03247)
nSD <-c(0.1565, 0.00656)

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
  
  Plot<- ggplot(data=Data,
                aes(x=Treatment, y=Value,fill=Treatment))+
    geom_boxplot()
  
  return(list(ANOsum,Plot))

  
}

AnoStats()