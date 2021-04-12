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

### EXAMINE CLUSTER WORDS
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

papers %>% 
  group_by(k5) %>% 
  tidytext::unnest_tokens(output = "words", input = "text") %>% 
  # remove stop words
  anti_join(stop_words, by = c("words" = "word")) %>% 
  # toss NA values.
  tidyr::drop_na() %>% 
  mutate(words_toss = stringr::str_detect(words, "\\.")) %>% 
  filter(words_toss == F) %>% 
  # clean out numebrs
  mutate(words_toss = stringr::str_detect(words,"[:digit:]")) %>% 
  filter(words_toss == F) %>% 
  # only keep words of > len 3
  mutate(words_toss = (nchar(words)<4)) %>% 
  filter(words_toss == F) %>% 
  mutate(k5 = as.factor(k5)) %>% 
  group_by(k5, words) %>% 
  count() %>% 
  
papers_counts <- papers %>% 
  group_by(k5) %>% 
  tidytext::unnest_tokens(output = "words", input = "text") %>% 
  # remove stop words
  anti_join(stop_words, by = c("words" = "word")) %>% 
  # toss NA values.
  tidyr::drop_na() %>% 
  mutate(words_toss = stringr::str_detect(words, "\\.")) %>% 
  filter(words_toss == F) %>% 
  # clean out numebrs
  mutate(words_toss = stringr::str_detect(words,"[:digit:]")) %>% 
  filter(words_toss == F) %>% 
  # only keep words of > len 3
  mutate(words_toss = (nchar(words)<4)) %>% 
  filter(words_toss == F) %>% 
  mutate(k5 = as.factor(k5)) %>% 
  group_by(k5, words) %>% 
  count()  
  
papers_totals <- papers %>% 
  group_by(k5) %>% 
  tidytext::unnest_tokens(output = "words", input = "text") %>% 
  # remove stop words
  anti_join(stop_words, by = c("words" = "word")) %>% 
  # toss NA values.
  tidyr::drop_na() %>% 
  mutate(words_toss = stringr::str_detect(words, "\\.")) %>% 
  filter(words_toss == F) %>% 
  # clean out numebrs
  mutate(words_toss = stringr::str_detect(words,"[:digit:]")) %>% 
  filter(words_toss == F) %>% 
  # only keep words of > len 3
  mutate(words_toss = (nchar(words)<4)) %>% 
  filter(words_toss == F) %>% 
  mutate(k5 = as.factor(k5)) %>% 
  group_by(k5) %>% 
  count()

paper_counts <- papers_counts %>% 
  left_join(papers_totals, by = "k5")

paper_counts <- papers_counts %>% 
  bind_tf_idf(words, document = k5, n)
  
  
p_tf_idf <- paper_counts %>% 
  group_by(k5) %>% 
  arrange(desc(tf_idf)) %>% 
  top_n(n = 15) %>% 
  ggplot(aes(x = reorder(words, tf_idf, order = T),
             y = tf_idf))+
  geom_col(fill = my_palette[1])+
  coord_flip()+
  facet_wrap(~k5, scales = "free")+
  labs(x = "words",y = "TF/IDF",
       title = "Defining words by Cluster: NHTSA Reports")+
  theme_light()+
  theme(aspect.ratio = 1,
        legend.position = "bottom",
        plot.title = element_text(size = 13),
        panel.grid = element_line(color = "white", linetype = 1,size = 0.25),
        panel.border = element_rect(color = "white"),
        strip.background = element_rect(fill = "white"),
        strip.text = element_text(color = "black", face = "bold"),
        axis.text.x = element_text(size = 8))

ggsave(plot = p_tf_idf,
       filename = here::here("Thesis_Tex/Content/Images/nhtsa_tf_idf.png"))


### GRAPH
graph_k5_1 <- papers %>% 
  tidytext::unnest_tokens( 
                        output = "words" ,
                        input = text, 
                        token = "skip_ngrams",
                        n = 2,
                        k = 3) %>%  
  filter(k5 == 1) %>% 
  # split bigram
  tidyr::separate(words, c("word1", "word2"), sep = " ") %>%
  # remove stop words
  anti_join(stop_words, by = c("word1" = "word")) %>% 
  anti_join(stop_words, by = c("word2" = "word")) %>% 
  # toss NA values.
  tidyr::drop_na() %>% 
  # clean out punctuation %>% 
  mutate(word1_toss = stringr::str_detect(word1, "\\.")) %>% 
  mutate(word2_toss = stringr::str_detect(word2, "\\.")) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # clean out numebrs
  mutate(word1_toss = stringr::str_detect(word1,"[:digit:]")) %>% 
  mutate(word2_toss = stringr::str_detect(word2,"[:digit:]")) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # only keep words of > len 3
  mutate(word1_toss = (nchar(word1)<4)) %>% 
  mutate(word2_toss = (nchar(word2)<4)) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # group each bigram.
  group_by(word1, word2) %>% 
  # count occurances.
  count() %>% 
  ungroup() %>% 
  arrange(desc(n)) %>% 
  filter(n > 50) %>% 
  #filter(k5 == 1) %>%
  select(word1,word2) %>% 
  # produce Graph.
  igraph::graph_from_data_frame() %>% 
  ggraph::ggraph(layout = "fr")+
  geom_edge_link(alpha = 0.7) +
  geom_node_point(color = my_palette[1]) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1, alpha = 0.6)+
  ggtitle("Cluster #2")

graph_k5_2 <- papers %>% 
  tidytext::unnest_tokens( 
    output = "words" ,
    input = text, 
    token = "skip_ngrams",
    n = 2,
    k = 3) %>%  
  filter(k5 == 2) %>% 
  # split bigram
  tidyr::separate(words, c("word1", "word2"), sep = " ") %>%
  # remove stop words
  anti_join(stop_words, by = c("word1" = "word")) %>% 
  anti_join(stop_words, by = c("word2" = "word")) %>% 
  # toss NA values.
  tidyr::drop_na() %>% 
  # clean out punctuation %>% 
  mutate(word1_toss = stringr::str_detect(word1, "\\.")) %>% 
  mutate(word2_toss = stringr::str_detect(word2, "\\.")) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # clean out numebrs
  mutate(word1_toss = stringr::str_detect(word1,"[:digit:]")) %>% 
  mutate(word2_toss = stringr::str_detect(word2,"[:digit:]")) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # only keep words of > len 3
  mutate(word1_toss = (nchar(word1)<4)) %>% 
  mutate(word2_toss = (nchar(word2)<4)) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # group each bigram.
  group_by(word1, word2) %>% 
  # count occurances.
  count() %>% 
  ungroup() %>% 
  arrange(desc(n)) %>% 
  filter(n > 100) %>% 
  #filter(k5 == 1) %>%
  select(word1,word2) %>% 
  # produce Graph.
  igraph::graph_from_data_frame() %>% 
  ggraph::ggraph(layout = "fr")+
  geom_edge_link(alpha = 0.7) +
  geom_node_point(color = my_palette[1]) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1, alpha = 0.6)+
  ggtitle("Cluster #2")

graph_k5_3 <- papers %>% 
  tidytext::unnest_tokens( 
    output = "words" ,
    input = text, 
    token = "skip_ngrams",
    n = 2,
    k = 3) %>%  
  filter(k5 == 3) %>% 
  # split bigram
  tidyr::separate(words, c("word1", "word2"), sep = " ") %>%
  # remove stop words
  anti_join(stop_words, by = c("word1" = "word")) %>% 
  anti_join(stop_words, by = c("word2" = "word")) %>% 
  # toss NA values.
  tidyr::drop_na() %>% 
  # clean out punctuation %>% 
  mutate(word1_toss = stringr::str_detect(word1, "\\.")) %>% 
  mutate(word2_toss = stringr::str_detect(word2, "\\.")) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # clean out numebrs
  mutate(word1_toss = stringr::str_detect(word1,"[:digit:]")) %>% 
  mutate(word2_toss = stringr::str_detect(word2,"[:digit:]")) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # only keep words of > len 3
  mutate(word1_toss = (nchar(word1)<4)) %>% 
  mutate(word2_toss = (nchar(word2)<4)) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # group each bigram.
  group_by(word1, word2) %>% 
  # count occurances.
  count() %>% 
  ungroup() %>% 
  arrange(desc(n)) %>% 
  filter(n > 30) %>% 
  #filter(k5 == 1) %>%
  select(word1,word2) %>% 
  # produce Graph.
  igraph::graph_from_data_frame() %>% 
  ggraph::ggraph(layout = "fr")+
  geom_edge_link(alpha = 0.7) +
  geom_node_point(color = my_palette[1]) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1, alpha = 0.6)+
  ggtitle("Cluster #3")

graph_k5_4 <- papers %>% 
  tidytext::unnest_tokens( 
    output = "words" ,
    input = text, 
    token = "skip_ngrams",
    n = 2,
    k = 3) %>%  
  filter(k5 == 4) %>% 
  # split bigram
  tidyr::separate(words, c("word1", "word2"), sep = " ") %>%
  # remove stop words
  anti_join(stop_words, by = c("word1" = "word")) %>% 
  anti_join(stop_words, by = c("word2" = "word")) %>% 
  # toss NA values.
  tidyr::drop_na() %>% 
  # clean out punctuation %>% 
  mutate(word1_toss = stringr::str_detect(word1, "\\.")) %>% 
  mutate(word2_toss = stringr::str_detect(word2, "\\.")) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # clean out numebrs
  mutate(word1_toss = stringr::str_detect(word1,"[:digit:]")) %>% 
  mutate(word2_toss = stringr::str_detect(word2,"[:digit:]")) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # only keep words of > len 3
  mutate(word1_toss = (nchar(word1)<4)) %>% 
  mutate(word2_toss = (nchar(word2)<4)) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # group each bigram.
  group_by(word1, word2) %>% 
  # count occurances.
  count() %>% 
  ungroup() %>% 
  arrange(desc(n)) %>% 
  filter(n > 30) %>% 
  #filter(k5 == 1) %>%
  select(word1,word2) %>% 
  # produce Graph.
  igraph::graph_from_data_frame() %>% 
  ggraph::ggraph(layout = "fr")+
  geom_edge_link(alpha = 0.7) +
  geom_node_point(color = my_palette[1]) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1, alpha = 0.6)+
  ggtitle("Cluster #4")

graph_k5_5 <- papers %>% 
  tidytext::unnest_tokens( 
    output = "words" ,
    input = text, 
    token = "skip_ngrams",
    n = 2,
    k = 3) %>%  
  filter(k5 == 5) %>% 
  # split bigram
  tidyr::separate(words, c("word1", "word2"), sep = " ") %>%
  # remove stop words
  anti_join(stop_words, by = c("word1" = "word")) %>% 
  anti_join(stop_words, by = c("word2" = "word")) %>% 
  # toss NA values.
  tidyr::drop_na() %>% 
  # clean out punctuation %>% 
  mutate(word1_toss = stringr::str_detect(word1, "\\.")) %>% 
  mutate(word2_toss = stringr::str_detect(word2, "\\.")) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # clean out numebrs
  mutate(word1_toss = stringr::str_detect(word1,"[:digit:]")) %>% 
  mutate(word2_toss = stringr::str_detect(word2,"[:digit:]")) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # only keep words of > len 3
  mutate(word1_toss = (nchar(word1)<4)) %>% 
  mutate(word2_toss = (nchar(word2)<4)) %>% 
  mutate(toss_pair = word1_toss|word2_toss) %>% 
  filter(toss_pair == F) %>% 
  # group each bigram.
  group_by(word1, word2) %>% 
  # count occurances.
  count() %>% 
  ungroup() %>% 
  arrange(desc(n)) %>% 
  filter(n > 50) %>% 
  #filter(k5 == 1) %>%
  select(word1,word2) %>% 
  # produce Graph.
  igraph::graph_from_data_frame() %>% 
  ggraph::ggraph(layout = "fr")+
  geom_edge_link(alpha = 0.7) +
  geom_node_point(color = my_palette[1]) +
  geom_node_text(aes(label = name), vjust = 1, hjust = 1, alpha = 0.6)+
  ggtitle("Cluster #5")

ggsave(filename = here::here("Thesis_Tex/Content/Images/graph_k5_1.png"), graph_k5_1)
ggsave(filename = here::here("Thesis_Tex/Content/Images/graph_k5_2.png"), graph_k5_2)
ggsave(filename = here::here("Thesis_Tex/Content/Images/graph_k5_3.png"), graph_k5_3)
ggsave(filename = here::here("Thesis_Tex/Content/Images/graph_k5_4.png"), graph_k5_4)
ggsave(filename = here::here("Thesis_Tex/Content/Images/graph_k5_5.png"), graph_k5_5)
