### Reddit df -> skip_gram graph
### Levi C. Nicklas
### 12/30/20
###
###
### Notes:  


convert_to_graphs <- function(){
  # Libraries
  library(here)
  library(furrr)
  
  plan(multicore)
  
  # Append all dataframes.
  mental_health_df <- readRDS("Data/RawData/subreddit-1.RDS")
  
  for(i in 2:18){
    temp <- readRDS(paste0("Data/RawData/subreddit-",i,".RDS"))
    mental_health_df <- rbind(mental_health_df, temp)
    rm(temp)
  }
  
  # import function
  source("Development/Scripts/df_to_graph_list.R")
  text_graphs <- furrr::future_map(.x = mental_health_df$comment,
                                  .f = df_to_graph_list)
  
  saveRDS(text_graphs, "Data/ProcessedData/reddit_graphs.RDS")
}
