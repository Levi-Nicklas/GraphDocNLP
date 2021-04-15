# Study 3b - H-Clustering WSS Analysis
# Author: Levi C. Nicklas
# Date: 4/6/21
#
# Notes:  For this study I will be comparing
#         HClust results in the NHTSA (and
#         reddit) docs. I will vary linkage
#         and distance metrics. Results will
#         be stored in a clean table, measuring
#         WSS on the kernel values.
###############################

## LIBRARIES ##
# Libraries
library(tidyverse)
library(here)
library(igraph)
library(graphkernels)
library(tidytext)
library(factoextra)



#cluster_vs_ss %>% 
#  ggplot(aes(x = num_clusters,
#             y = WSS)) +
#  geom_line(color = "purple")+
#  geom_point(color = "purple", size = 2) 


### LOOPING OVER DATASETS###
set.seed(23)
papers <- readRDS(here::here("Study3_HClustResults/papers.RDS"))
file_list <- list.files(here::here("Study3_HClustResults"))
file_list <- file_list[str_detect(file_list, pattern = "nhtsa_kernel")]

# Allocate Space
results <- list()

#Loop over Kernels and Calculate WSS
for(i in 1:length(file_list)){
  
  file.name <- file_list[i]
  
  nhtsa_kernel <- readRDS(here::here(paste0("Study3_HClustResults/",file.name)))
  ## COMPUTE CLUSTERING ##
  #Invert Similarity to Distance.
  nhtsa_kernel <- 1/nhtsa_kernel
  #Compute PCA.
  pca_kernel <- nhtsa_kernel %>% prcomp(scale. = T, center = T)
  # Hierarchical Clustering.
  dendro_pca <- dist(pca_kernel$rotation, method = "manhattan") %>% 
    hclust(method = "ward.D")
  # Cut Trees.
  papers$k2 <- dendro_pca %>% 
    cutree(k = 2)
  papers$k3 <- dendro_pca %>% 
    cutree(k = 3)
  papers$k4 <- dendro_pca %>% 
    cutree(k = 4)
  papers$k5 <- dendro_pca %>% 
    cutree(k = 5)
  papers$k6 <- dendro_pca %>% 
    cutree(k = 6)
  papers$k7 <- dendro_pca %>% 
    cutree(k = 7)
  # Add PCA Locations
  papers$x <- pca_kernel$x[,1]
  papers$y <- pca_kernel$x[,2]
  
  tmp_result <- data.frame(k_value = rep(0,6),
                           wss = rep(0,6))
  for(j in 1:6){
    k_js <- c("k2","k3","k4","k5","k6","k7")
    k_j <- c(quo(k2),quo(k3),quo(k4),quo(k5),quo(k6),quo(k7))
    
    # Compute Centroids
    cluster_centroids <- papers %>% 
      group_by(!!k_j[[j]]) %>% 
      summarize( x.mean = mean(x),
                 y.mean = mean(y))
    
    # Compute WSS for this K value.
    tmp_WSS <- papers %>% 
      left_join(cluster_centroids, by = k_js[j]) %>% 
      select(id, !!k_j[[j]], 
             x, y,
             x.mean, y.mean) %>% 
      mutate(dist.centr = sqrt((x - x.mean)^2 + (y - y.mean)^2)) %>% 
      group_by(!!k_j[[j]]) %>% 
      summarize(WSS = sum(dist.centr)) %>% 
      summarise(TWSS = sum(WSS)) %>% 
      pull()
    
    # store results
    tmp_result$k_value[j] <- k_js[j]
    tmp_result$wss[j] <- tmp_WSS
  }
  
  results[[i]] <- c(file.name, tmp_result)
}

### PLOT & TABLE OF WSS ###
# reformat `results`
str_extract_all(results[[1]][[1]], pattern = "[:digit:]{1,4}")

study3 <- data.frame(skip = rep(0,6*length(results)),
           sig = rep(0,6*length(results)),
           k_tree = rep(0,6*length(results)),
           wss = rep(0,6*length(results)))

for(i in 1:length(results)){
  num_values <- str_extract_all(results[[i]][[1]], pattern = "[:digit:]{1,4}")
  skip_val <- num_values[[1]][1]
  sig_val <- num_values[[1]][2]
  
  # Which rows to store in?
  row_indicies <- 6*(i-1) + (1:6)
  
  study3$skip[row_indicies] <- skip_val
  study3$sig[row_indicies] <- sig_val
  study3$k_tree[row_indicies] <- results[[i]]$k_value
  study3$wss[row_indicies] <- results[[i]]$wss
}

my_palette <-c("#ff333a","#f66025","#ffca3a","#8ac926","#1982c4","#6a4c93","#4b1592")

study3plot <- study3 %>% 
  group_by(skip,sig) %>% 
  ggplot(aes(x = k_tree,
             y = wss,
             group = .group))+
  geom_line(color = my_palette[1])+
  geom_point(size = 2, color = my_palette[1]) +
  facet_grid(rows = vars(sig), 
             cols = vars(skip))+
  labs(title = "Hierarchical Clustering Variation",
       subtitle = " Varying Skip-gram window (column) and \n Gaussian RBF parameter \u03C3 (row)",
       x = "Number of Clusters (k clusters)",
       y = "Within Sum of Squares")+
  theme_light()+
  theme(aspect.ratio = 1/1.618,
        plot.title = element_text(size = 18),
        axis.line = element_line(color = "black"),
        axis.ticks = element_line(color = "black"),
        panel.grid = element_line(color = "grey", linetype = 1,size = 0.25),
        strip.background = element_rect(fill = my_palette[5]),
        strip.text = element_text(color = "white", face = "bold"))

ggsave(study3plot, file = here::here("Study3_HClustResults/hclust_variation.png"))

  