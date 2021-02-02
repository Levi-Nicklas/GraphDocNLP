# Study 1 - KDE Clustering
# Author: Levi C. Nicklas
# Date: 1/16/21
#
# Notes:  For this study, first I will have to demonstrate
#         that computation and clustering with KDE works.
#         Following that, I need to tune the binwidth to 
#         optimize for variation within/between cluster(s).
###############################
library(tidyverse)
library(here)

# Read in a comment from the reddit datasets.
reddit_kenrel <- readRDS(here::here("Data/ProcessedData/reddit_graphkernel_150.RDS"))
reddit_sample <- readRDS(here::here("Data/ProcessedData/reddit_sample_150.RDS"))

# Pick a comment to assess.
set.seed(23)
random_comment <- sample(1:150, 1)
study_post <- reddit_sample[[random_comment]][[1]][[2]]
study_kernel <- reddit_kenrel[[random_comment]]

study_kernel %>% as.data.frame() %>% 
  drop_na() %>% 
  ggplot(aes(x = `.`))+
  geom_density(bw = 3000) +
  theme(plot.background = element_rect(fill = "white", colour = NA),
        panel.background = element_rect(fill = "white", colour = NA),
        axis.line = element_line(colour = "black"),
        panel.grid.major.x = element_line(color = "gray80", size = 0.5),
        panel.grid.major.y = element_line(color = "gray80", size = 0.5),
        title =element_text(size=12, face='bold'))

# Compute First and Second Derivs.
data.frame(x = density(study_kernel, bw = 3000, na.rm = T)$x,
           y = density(study_kernel, bw = 3000, na.rm = T)$y) %>% 
  mutate(x_l = lag(x),
         y_l = lag(y)) %>% 
  mutate(y_prime = (y - y_l)/(x - x_l)) %>% 
  mutate(y_prime_l = lag(y_prime)) %>% 
  mutate(y_prpr = (y_prime - y_prime_l)/(x - x_l)) %>% 
  ggplot(aes(x, y_prpr))+
  geom_line()+
  geom_point()+
  labs(title = "f''(x)")+
  theme(plot.background = element_rect(fill = "white", colour = NA),
        panel.background = element_rect(fill = "white", colour = NA),
        axis.line = element_line(colour = "black"),
        panel.grid.major.x = element_line(color = "gray80", size = 0.5),
        panel.grid.major.y = element_line(color = "gray80", size = 0.5),
        title =element_text(size=12, face='bold'))

# Find Zeros
data.frame(x = density(study_kernel, bw = 3000, na.rm = T)$x,
           y = density(study_kernel, bw = 3000, na.rm = T)$y) %>% 
  mutate(x_l = lag(x),
         y_l = lag(y)) %>% 
  mutate(y_prime = (y - y_l)/(x - x_l)) %>% 
  mutate(y_prime_l = lag(y_prime)) %>% 
  mutate(y_prpr = (y_prime - y_prime_l)/(x - x_l)) %>% 
  mutate(is_zero = ifelse(
    sign(y_prpr) != sign(lag(y_prpr)) 
    |
    sign(y_prpr) != sign(lead(y_prpr))
    , T,F
    )) %>% 
  ggplot(aes(x, y_prpr))+
  geom_line()+
  geom_point(aes(color = is_zero))+
  labs(title = "f''(x)")+
  theme(plot.background = element_rect(fill = "white", colour = NA),
        panel.background = element_rect(fill = "white", colour = NA),
        axis.line = element_line(colour = "black"),
        panel.grid.major.x = element_line(color = "gray80", size = 0.5),
        panel.grid.major.y = element_line(color = "gray80", size = 0.5),
        title =element_text(size=12, face='bold'))

# 
ex_df <- data.frame(x = density(study_kernel, bw = 3000, na.rm = T, n = 1024)$x,
           y = density(study_kernel, bw = 3000, na.rm = T, n = 1024)$y) %>% 
  mutate(x_l = lag(x),
         y_l = lag(y)) %>% 
  mutate(y_prime = (y - y_l)/(x - x_l)) %>% 
  mutate(y_prime_l = lag(y_prime)) %>% 
  mutate(y_prpr = (y_prime - y_prime_l)/(x - x_l)) %>% 
  mutate(is_zero = ifelse(
    sign(y_prpr) != sign(lag(y_prpr)) 
    |
      sign(y_prpr) != sign(lead(y_prpr))
    , T,F
  )) 

# Get cluster breaks.
ex_cluster_breaks <- ex_df %>% 
  filter(is_zero == TRUE) %>% 
  select(x) %>% 
  pull()

mean_break_pts <- function(est_breaks_pts){
  # allocate space.
  mean_pts <- rep(0, length(est_breaks_pts)-1)
  
  # loop through pairs.
  for(i in 1:(length(est_breaks_pts)-1)){
    mean_tmp <- mean(c(est_breaks_pts[i], est_breaks_pts[i+1]))
    mean_pts[i] <- mean_tmp
  }
  return(mean_pts)
}

ex_cluster_breaks <- mean_break_pts(ex_cluster_breaks)


# Assign labels
label_cluster <- function(values, breaks){
  number_of_breaks <- length(breaks)
  
  # Allocate Space.
  cluster_cols <- data.frame(x = values)
  cluster_labels <- rep(0,length(values))
  # Check if value is in break bounds.
  for(i in 1:number_of_breaks){
    bool_in_cluster <- (values > breaks[i] & values < breaks[i+1]) 
    #cluster_labels <- ifelse(bool_in_cluster, i, NA)
    cluster_labels <- bool_in_cluster
    # Add new cluster label column
    cluster_cols <- cbind(cluster_cols, cluster_labels)
    # Name each column.
    colnames(cluster_cols) <- c(colnames(cluster_cols[1:length(cluster_cols)-1]),i)
  }
  return(cluster_cols)
}

label_cluster(ex_df$x, ex_cluster_breaks) 
ex_df2 <- cbind(1:nrow(ex_df), ex_df, label_cluster(ex_df$x, ex_cluster_breaks))
colnames(ex_df2) <- c("id", colnames(ex_df2[,2:ncol(ex_df2)]))

ex_df_labels <- ex_df2[c(1,10:37)] %>% 
  pivot_longer(cols = c("1":"27")) %>% 
  filter(value == TRUE)

ex_df <- left_join(ex_df2, ex_df_labels, by = c())  

ex_df %>% 
  #filter(!is.na(name)) %>% 
  ggplot(aes(x = x, y = y, color = name)) +
  geom_point()
  