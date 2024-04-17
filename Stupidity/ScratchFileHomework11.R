# load packages ----
library(log4r)
library(TeachingDemos)
library(tidyverse)
library(pracma)
library(ggmosaic)

# load any additional packages here...


# source function files ----
source("barracudar/DataTableTemplate.R")
source("barracudar/AddFolder.R")
source("barracudar/BuildFunction.R")
source("barracudar/MetaDataTemplate.R")
source("barracudar/CreatePaddedLabel.R")
source("barracudar/InitiateSeed.R")
source("barracudar/SetUpLog.R")
source("barracudar/SourceBatch.R")



######

#list.files() gathers character strings of file names
filelist<-list.files("C:/Users/elyre/Desktop/RemesBiol6100/Stupidity/NEON_count-landbird")
filelist
filefull<-vector("list",length=8)
filenames<-vector( length=8)
for (i in 1:8){
  setwd(paste0("C:/Users/elyre/Desktop/RemesBiol6100/Stupidity/NEON_count-landbird","/",filelist[i]))
  
  filenames[i] <-(list.files(pattern = "countdata"))
  #filefull[i]<-read.csv(filenames[[i]])
    data_table_template(data_frame=read.csv(filenames[i]), file_name=paste0("count data"))
    #paste0("C:/Users/elyre/Desktop/RemesBiol6100/Stupidity/NEON_count-landbird","/",filenames[i]))))
setwd("C:/Users/elyre/Desktop/RemesBiol6100/Stupidity")

}
add_folder(folder_names="DirtyData")
for (i in filenames) {
  data_table_template(data_frame=read.csv(filenames[i]), file_name=paste0(i, "Count Data"))
}
