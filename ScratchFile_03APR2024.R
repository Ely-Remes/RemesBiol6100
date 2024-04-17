x<- rep(1:10, times=25)

rows<-5
columns<-4

zero_counter<-function(vec){

  counter<-0
  for (i in vec){
    if (i == 0){
      counter<- counter+1
    }
  }
  
  return(counter)
}
zero_counter(vec=x)



#######################################################
SubsetOfZero<-function(vec){
  return(sum(vec == 0))
}
SubsetOfZero(vec=x)  

######################################################

EasyMatrix<-function(rows=x,columns=y){
  
  m<-matrix(nrow=rows,ncol=columns)
  for(i in 1:nrow(m)) {
    for(j in 1:ncol(m)) {
     m[i,j]<- i*j
    }
  }
  return(m)
}
EasyMatrix(rows=7,columns=3)
####################################

########################################################################
source("Homework_09Functions.R")

nName= c("Potatoes","Carrots","Radishes")
nSize= c(rep(20, times=3))
nMean= c(17,25, 19)
nSD= c(runif(3))

VeggieWeight<-FakeDataGeneration()

Randomizer<-function(x){
  
  
CleanWeight<-mutate(x, Treatment,Value=round(Value, digits=1))
NewWeight<-sample(CleanWeight$Value)
  
  
  
MixedWeight<-mutate(CleanWeight, Treatment, NewWeight)
MixedWeight<-select(MixedWeight, Treatment, NewWeight)

Answer<-group_by(MixedWeight, Treatment) %>% summarize(m = mean(NewWeight))
return(unlist(Answer[,2]))
}



Randomizer(x=VeggieWeight)


FrameWork<- data.frame(matrix(nrow=100,ncol=3))

for (i in 1:nrow(FrameWork)) {
  FrameWork[i,]<-Randomizer(x=VeggieWeight)
}

FrameWork<-mutate(FrameWork, ID=(1:100))
FrameWork<-select(FrameWork, ID,Potatoes=X1,Carrots=X2,Radishes=X3)

hist(x=FrameWork$Carrots, col="darkorange",length.out=8,xlab="Carrot Mean Distribution" )
hist(x=FrameWork$Potatoes,
     col="tan3",length.out=8,
     xlab="Potato Mean Distribution")
hist(x=FrameWork$Radishes,
     col="purple", length.out=8,
    xlab="Radish Mean Distribution" )