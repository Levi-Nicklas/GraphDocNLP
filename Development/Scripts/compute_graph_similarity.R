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
  require(here)
  
  source(here::here("Development/Scripts/convert_vertex_labels.R"))
  
  # Edit Graph List to Op on.
  #graph_list <- reddit_graphs_s
  graph_list <- nhtsa_graphs
  #Allocate Storage
  result <- rep(0,length(graph_list))
  
  # Compute Similarity btwn 1 graph and all others. FOR REDDIT
  # for(i in 1:length(graph_list)){
  #   if(length(igraph::vertex.attributes(graph_list[[i]][[1]][[1]])) > 0 & 
  #      length(igraph::vertex.attributes(input_graph[[1]][[1]])) > 0 ){
  #     
  #     # Correct Labels Issue.
  #     tmp_graph_list <- convert_vertex_labels(graph_list[[i]][[1]][[1]], input_graph[[1]][[1]])
  #     #print(paste0("Calculating Graph: #",i))
  #     K <- graphkernels::CalculateEdgeHistKernel(tmp_graph_list)
  #     #K <- graphkernels::CalculateConnectedGraphletKernel(tmp_graph_list,5)
  #     similarity_value <- K[1,2]
  #     result[i] <- similarity_value
  #   } else {
  #     #print(paste0("Skipping Graph: #",i))
  #     result[i] <- NA
  #   }
  # }
  
  # FOR NHTSA
  for(i in 1:length(graph_list)){
    if(length(igraph::vertex.attributes(graph_list[[i]][[1]])) > 0 & 
       length(igraph::vertex.attributes(input_graph[[1]])) > 0 ){
      
      # Correct Labels Issue.
      tmp_graph_list <- convert_vertex_labels(graph_list[[i]][[1]], input_graph[[1]])
      #print(paste0("Calculating Graph: #",i))
      K <- graphkernels::CalculateEdgeHistKernel(tmp_graph_list)
      #K <- graphkernels::CalculateConnectedGraphletKernel(tmp_graph_list,5)
      similarity_value <- K[1,2]
      result[i] <- similarity_value
    } else {
      #print(paste0("Skipping Graph: #",i))
      result[i] <- NA
    }
  }
  
  return(result)
}

