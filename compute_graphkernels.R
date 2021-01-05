# Compute Graph Kernels
# Levi C. Nicklas
# Date: 1/4/2021
#
#
# Notes:  
#

compute_graph_kernel <- function(graph_list){
  require(graphkernels)
  
  #allocate storage
  #kernel_mat <- matrix(rep(0,length(graph_list)*length(graph_list)),nrow = length(graph_list))
  
  for(i in 1:length(graph_list)){
    for(j in 1:length(graph_list)){
      temp_mat <- graphkernels::CalculateEdgeHistKernel(
        list(
          reddit_graphs[[i]][[1]],
          reddit_graphs[[j]][[1]])
      )
      
      kernel_mat[i,j] <- temp_mat[1,2]
      kernel_mat[i,i] <- temp_mat[1,1]
      kernel_mat[j,j] <- temp_mat[2,2]
    }
  }
  
  #return(kernel_mat)
}
