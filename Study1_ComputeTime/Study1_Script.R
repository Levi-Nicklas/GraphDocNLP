# Study 1 - Compute Time
# Author: Levi C. Nicklas
# Date: 1/16/21
#
# Notes:  In this first study, the computation time will be 
#         assessed by data set and by kernel. Questions to 
#         answer include:
#           - How do the data sets differ in their computation time?
#           - Does the kernel choice significantly impact comp. time?
#           - Does the length of text or number of obs. units effect the 
#             computation time more?
###############################
# Libraries
library(tidyverse)
library(here)
library(igraph)
library(tictoc)

# ggplot2 themeing

# Functions
source(here::here("Development/Scripts/compute_graph_similarity.R"))
source(here::here("Development/Scripts/compute_kernel.R"))

###############################

## Reddit ##
# Read in Data
reddit_graphs <- readRDS(here::here("Data/ProcessedData/reddit_graphs.RDS"))

# Sample
set.seed(23)
reddit_graphs_s <- sample(reddit_graphs, 350)

# Compute the Kernel
tic()
compute_kernel()
toc()
result <- readRDS(here::here("Data/ProcessedData/reddit_graphkernel_350.RDS"))

# Record Results from compute time.
# [x] Edge Histogram Kerenel
# [ ]
# [ ] 
compute_time <- data.frame(n = c(10, 25, 50, 75, 100,
                                 125, 150, 175, 200, 225,
                                 250, 275,300,325, 350),
                           t = c(0.638, 12.202, 19.907,13.209, 23.011,
                                 37.686, 51.337, 73.71, 97.643, 123.555, 
                                 150.517, 192.89, 246.782,325.076,425.469))

compute_time %>% 
  ggplot()+
  geom_point(aes(n,t)) +
  geom_smooth(aes(n,t))+
  geom_abline(slope = 1, intercept = 0, lty = 2, color = "red") +
  labs(x = "Number of Graphs",
       y = "Time (Seconds)")
  
