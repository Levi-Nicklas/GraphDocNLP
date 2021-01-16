# Compute Graph Similarity
# Levi C. Nicklas
# Date: 1/4/2021
#
#
# Notes:  
#


compute_graph_similarity <- function(graph_list, input_graph){
  require(graphkernels)
  
  #Allocate Storage
  result <- rep(0,length(graph_list))
  
  # Compute Similarity btwn 1 graph and all others.
  for(i in 1:length(graph_list)){
    K <- graphkernels::CalculateEdgeHistKernel(input_graph,graph_list[[i]][1])
    similarity_value <- K[1,2]
    result[i] <- similarity_value
  }
  return(result)
}

