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
study_sample <- sample(1:length(reddit_graphs),size = 150 ,replace = F)
reddit_graphs_s <- reddit_graphs[study_sample]

# Compute the Kernel
tic()
compute_kernel()
toc()
saveRDS(reddit_graphs[study_sample], here::here("Data/ProcessedData/reddit_sample_150.RDS"))
beepr::beep(sound = 7)
result <- readRDS(here::here("Data/ProcessedData/reddit_graphkernel_150.RDS"))

# Record Results from compute time.
# [x] Edge Histogram Kerenel
# [ ]
# [ ] 

# Edge Histogram DF.
compute_time <- data.frame(n = c(10, 25, 50, 75, 100,
                                 125, 150, 175, 200, 225,
                                 250, 275,300,325),
                           t = c(1.911, 7.933, 26.696,57.828, 107.149,
                                 171.461, 257.765, 386.107, 569.514, 802.679, 
                                 922.383, 1344.21, 1673.508,2244.22))

edge_hist_time_plot <- compute_time %>% 
  ggplot()+
  geom_smooth(aes(n,t), color = "gray50", se = F, size = 0.5, lty = 2)+
  geom_point(aes(n,t), shape = 21, size = 2.25, color = "black", fill = "#0b21e8") +
  #geom_abline(slope = 1, intercept = 0, lty = 2, color = "red") +
  labs(x = "Number of Graphs",
       y = "Time (Seconds)",
       title = "Computation Time by Graphs Processed",
       subtitle = "Graph Kernel: Edge Histogram Kernel") +
  scale_y_continuous(limits = c(0,2500))+
  scale_x_continuous(limits = c(0,350))+
  theme(plot.background = element_rect(fill = "white", colour = NA),
        panel.background = element_rect(fill = "white", colour = NA),
        axis.line = element_line(colour = "black"),
        panel.grid.major.x = element_line(color = "gray80", size = 0.5),
        panel.grid.major.y = element_line(color = "gray80", size = 0.5),
        title =element_text(size=12, face='bold'))

ggsave(here::here("Study1_ComputeTime/edgeHistTimePlot.png"), plot = edge_hist_time_plot)

