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
  
  plan(multisession, workers = 4)
  
  ### REDDIT POSTS ###
  
  post_thread_graphs <- list()

  source(here::here("Development/Scripts/df_to_graph_list.R"))
  
  text_graphs <- furrr::future_map(.x = post_thread_text_sample$text,
                                   .f = df_to_graph_list)
  return(text_graphs)
  
  ### NHTSA PAPERS ###
  # papers <- readRDS(here::here("Data/NHTSA/RawData/ConsolidatedPapers.rds"))
  # 
  # # import function
  # source(here::here("Development/Scripts/df_to_graph_list.R"))
  # text_graphs <- furrr::future_map(.x = papers$text,
  #                                 .f = df_to_graph_list)
  # 
  # saveRDS(text_graphs, "Data/NHTSA/ProcessedData/nhtsa_graphs.RDS")
}
