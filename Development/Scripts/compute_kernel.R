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
  
  plan(multisession, workers = 8)
  
  text_kernel <- furrr::future_map(.x = thread_graphs,
                                   .f = compute_graph_similarity,
                                   .options = furrr_options(seed = T))
  
  #saveRDS(text_kernel, "Data/ProcessedData/reddit_graphkernel_325.RDS")
  return(text_kernel)
  saveRDS(text_kernel, "Data/ProcessedData/redditthreads_graphkernel_all.RDS")
}




