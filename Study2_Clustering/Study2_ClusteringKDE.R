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
  geom_density(bw = 2000) +
  theme(plot.background = element_rect(fill = "white", colour = NA),
        panel.background = element_rect(fill = "white", colour = NA),
        axis.line = element_line(colour = "black"),
        panel.grid.major.x = element_line(color = "gray80", size = 0.5),
        panel.grid.major.y = element_line(color = "gray80", size = 0.5),
        title =element_text(size=12, face='bold'))

# Compute First and Second Derivs.
data.frame(x = density(study_kernel, bw = 1000, na.rm = T)$x,
           y = density(study_kernel, bw = 1000, na.rm = T)$y) %>% 
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
data.frame(x = density(study_kernel, bw = 1000, na.rm = T)$x,
           y = density(study_kernel, bw = 1000, na.rm = T)$y) %>% 
  mutate(x_l = lag(x),
         y_l = lag(y)) %>% 
  mutate(y_prime = (y - y_l)/(x - x_l)) %>% 
  mutate(y_prime_l = lag(y_prime)) %>% 
  mutate(y_prpr = (y_prime - y_prime_l)/(x - x_l)) %>% 
  mutate(is_zero = ifelse(
    sign(y_prpr) != sign(lag(y_prpr)) 
    |
    sign(y_prpr) != sign(lead(y_prpr))
    , "T","F"
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
