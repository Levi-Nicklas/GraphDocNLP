# Study 3a - H-Clustering Prep
# Author: Levi C. Nicklas
# Date: 4/6/21
#
# Notes:  For this study I will be comparing
#         HClust results in the NHTSA (and
#         reddit) docs. First I need to get 
#         nice reusable kernels that I can run
#         tests on. 
# 
#         Vary Skip Window 2-4
#         Vary RBF Sigma (800-1200, by 100)
################################################

## LIBRARIES ##
# Libraries
library(tidyverse)
library(here)
library(igraph)
library(graphkernels)
library(tidytext)


## DATA IMPORT AND REFORMAT ##
# Data Import
file.names <- list.files(path = here::here("Data/NHTSA/RawData"))
papers <- list()

for(i in 1:length(file.names)){
  temp.file.name <- here::here(paste0("Data/NHTSA/RawData/", file.names[i]))
  
  if(grepl("paper_",temp.file.name)){
    temp.file <- readRDS(temp.file.name)
    
    temp.file <- paste(temp.file, collapse = ". ")
    
    papers[i] <- temp.file
  }
}

papers <- data.frame(id = 1:length(papers),
                     text = unlist(papers))
saveRDS(papers, here::here("Study3_HClustResults/papers.RDS"))

# CHANGE SKIP SIZE IN FUNCTION SCRIPT
source(here::here("Development/Scripts/df_to_graph_list.R"))

nhtsa_graphs <- df_to_graph_list(papers$text)

# CHANGE SIGMA IN FUNCTION SCRIPT
source(here::here("Development/Scripts/compute_graph_similarity.R"))
nhtsa_kernel <- matrix(rep(0,48*48), nrow = 48)


for(i in 1:length(nhtsa_graphs)){
  nhtsa_kernel[i,] <- compute_graph_similarity(nhtsa_graphs[[i]])
}

saveRDS(nhtsa_kernel, here::here("Study3_HClustResults/nhtsa_kernel_skip4_sig1200.RDS"))