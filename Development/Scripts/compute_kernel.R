# Compute Graph Kernels
# Levi C. Nicklas
# Date: 1/4/2021
#
#
# Notes:  
#


compute_kernel <- function(){
  # Libraries
  require(furrr)
  
  plan(multicore)
  
  text_kernel <- furrr::future_map(.x = reddit_graphs_s,
                                   .f = compute_graph_similarity)
  
  saveRDS(text_kernel, "../../Data/ProcessedData/reddit_graphkernel.RDS")
}




