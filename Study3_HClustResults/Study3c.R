# Study 3c - H-Clustering Prep
# Author: Levi C. Nicklas
# Date: 4/6/21
#
# Notes:  
###############################

## LIBRARIES ##
# Libraries
library(tidyverse)
library(here)
library(igraph)
library(graphkernels)
library(tidytext)
library(factoextra)
my_palette <-c("#ff333a","#f66025","#ffca3a","#8ac926","#1982c4","#6a4c93","#4b1592")

papers <- readRDS(here::here("Study3_HClustResults/papers.RDS"))

## READ IN THE FIVE KERNELS OF CONCERN ##
nhtsa_a <- readRDS(here::here("Study3_HClustResults/nhtsa_kernel_skip3_sig1000.RDS"))
nhtsa_b <- readRDS(here::here("Study3_HClustResults/nhtsa_kernel_skip2_sig1100.RDS"))
nhtsa_c <- readRDS(here::here("Study3_HClustResults/nhtsa_kernel_skip3_sig1100.RDS"))
nhtsa_d <- readRDS(here::here("Study3_HClustResults/nhtsa_kernel_skip3_sig800.RDS"))
nhtsa_e <- readRDS(here::here("Study3_HClustResults/nhtsa_kernel_skip3_sig900.RDS"))

# Convert from Similarity Kernel to Dist Mat.
similarity_to_dist <- function(x){
  x <- 1/x
}

similarity_to_dist(nhtsa_a)
similarity_to_dist(nhtsa_b)
similarity_to_dist(nhtsa_c)
similarity_to_dist(nhtsa_d)
similarity_to_dist(nhtsa_e)

### ANALYSIS A###
#Compute PCA.
pca_kernel <- nhtsa_a %>% prcomp(scale. = T, center = T)
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
            
a_tree <- fviz_dend(dendro_pca, k = 5, cex = 0.5, k_colors = my_palette,
          color_labels_by_k = F) +
  labs(x = "Document ID",
       y = "Height",
       title = "Cluster Results - A",
       subtitle = " Skip-gram = 3, \u03C3 = 1000,\n # of Clusters = 5")+
  theme(axis.text.x = element_text(size = 5))
a_clusters <- papers$k5

### ANALYSIS B###
#Compute PCA.
pca_kernel <- nhtsa_b %>% prcomp(scale. = T, center = T)
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

b_tree <- fviz_dend(dendro_pca, k = 3, cex = 0.5, k_colors = my_palette,
          color_labels_by_k = F) +
  labs(x = "Document ID",
       y = "Height",
       title = "Cluster Results - B",
       subtitle = " Skip-gram = 2, \u03C3 = 1100,\n # of Clusters = 3")+
  theme(axis.text.x = element_text(size = 5))
b_clusters <- papers$k3
### ANALYSIS C###
pca_kernel <- nhtsa_c %>% prcomp(scale. = T, center = T)
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

c_tree <- fviz_dend(dendro_pca, k = 5, cex = 0.5, k_colors = my_palette,
                    color_labels_by_k = F) +
  labs(x = "Document ID",
       y = "Height",
       title = "Cluster Results - C",
       subtitle = " Skip-gram = 3, \u03C3 = 1100,\n # of Clusters = 5")+
  theme(axis.text.x = element_text(size = 5))
c_clusters <- papers$k5

### ANALYSIS D###
pca_kernel <- nhtsa_c %>% prcomp(scale. = T, center = T)
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

d_tree <- fviz_dend(dendro_pca, k = 5, cex = 0.5, k_colors = my_palette,
                    color_labels_by_k = F) +
  labs(x = "Document ID",
       y = "Height",
       title = "Cluster Results - D",
       subtitle = " Skip-gram = 3, \u03C3 = 800,\n # of Clusters = 6")+
  theme(axis.text.x = element_text(size = 5))
d_clusters <- papers$k6

### ANALYSIS E###
pca_kernel <- nhtsa_c %>% prcomp(scale. = T, center = T)
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

e_tree <- fviz_dend(dendro_pca, k = 7, cex = 0.5, k_colors = my_palette,
                    color_labels_by_k = F) +
  labs(x = "Document ID",
       y = "Height",
       title = "Cluster Results - E",
       subtitle = " Skip-gram = 3, \u03C3 = 900,\n # of Clusters = 7")+
  theme(axis.text.x = element_text(size = 5))
e_clusters <- papers$k7

### PATCHWORK ###
library(patchwork)

p <- a_tree+b_tree+c_tree+d_tree+e_tree
p

ggsave(p,filename = here::here("Study3_HClustResults/5cluster.png"),units = "in", width = 13, height = 6)

## GROUP ANALYSIS ##
# Did stuff appear in the same cluster??
heatmap_matrix <- matrix(rep(0,48*48),nrow = 48)

clusters_study <- list(a_clusters,b_clusters,c_clusters,d_clusters,e_clusters)

for(k in 1:length(clusters_study)){
  for(i in 1:length(clusters_study[[k]])){
    tmp_heatmap_matrix <- matrix(rep(0,48*48),nrow = 48)
    for(j in 1:length(clusters_study[[k]])){
      if(clusters_study[[k]][i] == clusters_study[[k]][j]){
        heatmap_matrix[i,j] <- TRUE
      } else {
        heatmap_matrix[i,j] <- FALSE
      }
    }
  }
  heatmap_matrix <- heatmap_matrix | tmp_heatmap_matrix
}


comembers5 <- heatmap_matrix %>% 
  as.data.frame() %>% 
  mutate(row = row_number()) %>% 
  pivot_longer(cols = c(1:48)) %>% 
  mutate(col = str_extract(name, pattern = "[:digit:]{1,2}")) %>% 
  ggplot(aes(as.numeric(row), as.numeric(col), fill = as.factor(value)))+
  geom_tile(color = "black", size = 0.25)+
  scale_fill_manual(values = my_palette[c(T,F,F,F,T,F,F)])+
  scale_y_discrete(limits = factor(1:48))+
  scale_x_discrete(limits = factor(1:48))+
  labs(fill = "Appeared in same clusters every time:",
       x = "Document ID",
       y = "Document ID",
       title = "Co-membership Across Five Clusterings")+
  theme_light()+
  theme(aspect.ratio = 1,
        legend.position = "bottom",
        plot.title = element_text(size = 16),
        panel.grid = element_line(color = "white", linetype = 1,size = 0.25),
        panel.border = element_rect(color = "white"),
        strip.background = element_rect(fill = "#E85D04"),
        strip.text = element_text(color = "#370617", face = "bold"),
        axis.text.x = element_text(angle = 90))

#ggsave(comembers5, filename = here::here("Study3_HClustResults/comembers5.png"), units = "in", width = 8, height = 8)

heatmap_matrix %>%  
  as.data.frame() %>% 
  mutate(row = row_number()) %>% 
  pivot_longer(cols = c(1:48)) %>% 
  mutate(col = str_extract(name, pattern = "[:digit:]{1,2}")) %>% 
  select(row,col, value) %>% 
  group_by(row) %>% 
  summarize(n_shared = sum(value)) %>% 
  arrange(desc(n_shared))
  

#################################
## POINTS PLOT ##
## Add PCA Locations
#papers$x <- pca_kernel$rotation[,1]
#papers$y <- pca_kernel$rotation[,2]       
#
# papers %>% 
#   ggplot(aes(x = x,
#              y = y,
#              color = factor(k5))) +
#   geom_point(size = 2)+
#   scale_color_manual(values = my_palette) +
#   theme_light()+
#   theme(aspect.ratio = 1/1.618,
#         plot.title = element_text(size = 18),
#         axis.line = element_line(color = "black"),
#         axis.ticks = element_line(color = "black"),
#         panel.grid = element_line(color = "grey", linetype = 1,size = 0.25),
#         strip.background = element_rect(fill = "white"),
#         strip.text = element_text(color = "#370617", face = "bold"))