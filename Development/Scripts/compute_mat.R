# Compute Graph Kernels
# Levi C. Nicklas
# Date: 1/4/2021
#
#
# Notes:  
#


compute_kernel <- function(){
  # Libraries
  library(here)
  library(furrr)
  
  plan(multicore)
  
  text_graphs <- furrr::future_map(.x = reddit_graphs_s,
                                   .f = compute_graph_similarity)
  
  saveRDS(text_graphs, "Data/ProcessedData/reddit_graphkernel_150.RDS")
}




