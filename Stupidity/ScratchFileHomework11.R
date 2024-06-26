# load packages ----
library(log4r)
library(TeachingDemos)
library(tidyverse)
library(pracma)
library(ggmosaic)

# load any additional packages here...

setwd("/Users/elyre/Desktop/Comp Bio/RemesBiol6100/Stupidity")
# source function files ----
source("barracudar/DataTableTemplate.R")
source("barracudar/AddFolder.R")
source("barracudar/BuildFunction.R")
source("barracudar/MetaDataTemplate.R")
source("barracudar/CreatePaddedLabel.R")
source("barracudar/InitiateSeed.R")
source("barracudar/SetUpLog.R")
source("barracudar/SourceBatch.R")

WorkingDirectory<-paste0(getwd(),"/NEON_count-landbird")

filelist <- list.files(WorkingDirectory ,pattern="BART")

# use a for loop for number of files that we're concerned with, pull out files

# paste() or paste0() function concatenates strings
# paste0("Here is ","the ","filepath: ", filelist[1]) # example

# make an empty vector
filenames <- c()

# make matrix of file names
for (i in 1:length(filelist)) {
  setwd(paste0(WorkingDirectory,"/", filelist[i])) # create new file path to go to
  
  filenames[i] <- list.files(pattern="countdata") # any time the file has "countdata" in it, it pulls it out
}

filenames

getinfo <- function(filelist,filenames) {
  
  metadata <- matrix(0,length(filelist),4)
  colnames(metadata) <- c("File","Year","Total # Individuals", "Species Richness")
  
  for (i in 1:length(filelist)) { # for every folder (there is only one good csv per folder)
    
    # go into the folder listed at filelist[i]
    setwd(paste0(WorkingDirectory,"/", filelist[i]))
    
    # get the csv data from filename
    csvdata <- read.csv(filenames[i]) # read in the csv from this folder, off of the list of good csvs!
    csvdata
    
    dfcsv <- data.frame(csvdata)
    dfcsv
    
    # GETTING INFORMATION
    
    # get rid of empty/missing cases
    dfcsv <- na.omit(dfcsv[,1:20]) # rows after 20 are either all NA or no NA, so this seems prudent if I still want to have stuff to work with
    dfcsv
    
    # extract the year from the file name
    year <- str_sub(filenames[i],43,46)
    
    
    # calculate total individuals found
    total_individuals <- nrow(dfcsv)
    
    # calculate total number of unique species
    species_richness <- length(unique(dfcsv[,12]))
    
    # fill in the empty vector for each csv
    metadata[i,1:4] <- c(filelist[i], year, total_individuals, species_richness)
    # number of items to replace is not a multiple of replacement length
    
  }
  
  return(metadata)
  
}

getinfo(filelist,filenames)
