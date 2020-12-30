### Reddit Data Collect
### Levi C. Nicklas
### 10/25/20
###
###
### Notes:  This data collected will be from reddit. 
###         Target data is that which related to mental
###         health and the open forum discussion of 
###         the issues, stigmas, and other challenges
###         surrounding those experiencing mental health
###         issues.
###
###         The package {RedditExtractoR} will be used 
###         to obtain the data. This will then be written
###         out to the data folder in an .RDS or .csv format.

library(tidyverse)
library(RedditExtractoR)


mental_health <- c("anxious", "anxiety", 
                   "depressed", "depression",
                   "mental", "illness", "scared",
                   "afraid", "sad", "emotion", "anger",
                   "angry", "upset", "suicide", "abuse",
                   "emotional","help", "addiction")

reddit_data <- list()

for(i in 1:length(mental_health)){
  reddit_temp <- RedditExtractoR::get_reddit(search_terms = mental_health[i], 
                             #regex_filter = ,
                             subreddit = "mentalhealth",
                             cn_threshold = 10,
                             sort_by = "comments",
                             wait_time = 3)
  
  reddit_data[[i]] <- reddit_temp
}

write_rds(reddit_data, "Data/RawData/mentalhealth_reddit_20201025.RDS")
