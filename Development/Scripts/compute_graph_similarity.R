# Compute Graph Similarity
# Levi C. Nicklas
# Date: 1/4/2021
#
#
# Notes:  
#


compute_graph_similarity <- function(input_graph){
  require(graphkernels)
  require(igraph)
  
  # Edit Graph List to Op on.
  graph_list <- reddit_graphs_s
  
  #Allocate Storage
  result <- rep(0,length(graph_list))
  
  # Compute Similarity btwn 1 graph and all others.
  for(i in 1:length(graph_list)){
    if(length(igraph::vertex.attributes(graph_list[[i]][[1]])) > 0 & 
       length(igraph::vertex.attributes(input_graph[[1]])) > 0 ){
      tmp_graph_list <- list(graph_list[[i]][[1]], input_graph[[1]])
      #print(paste0("Calculating Graph: #",i))
      K <- graphkernels::CalculateEdgeHistKernel(tmp_graph_list)
      similarity_value <- K[1,2]
      result[i] <- similarity_value
    } else {
      #print(paste0("Skipping Graph: #",i))
      result[i] <- NA
    }
  }
  return(result)
}

