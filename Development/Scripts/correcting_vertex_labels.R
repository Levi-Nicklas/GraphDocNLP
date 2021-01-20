# convert_vertex_labels
# Levi C. Nicklas
# 1/20/2021 -- *Happy Inauguration Day*
#
#
# Notes:  This function converts text labels of two graphs and maps them to integer values.
#         {graphkernels} only works with integer labels on verticies. The function finds 
#         the union of unique words/labels and then maps each unique label to an integer
#         and then assigns the corresponding label to the correct vertex.

convert_vertex_labels <-  function(g1, g2){
  # Libs Req.
  require(magrittr)
  require(dplyr)
  require(igraph)
  require(graphkernels)
  
  # Grab vertex labels (words).
  v.g1 <- unlist(get.vertex.attribute(g1))
  v.g2 <- unlist(get.vertex.attribute(g2))
  
  # Build a dataframe that maps words to integers (1 to 1).
  map_to_int <- seq(1,length(unique(c(v.g1,v.g2))))
  map_to_int <- data.frame(word = unique(unique(c(v.g1,v.g2))),
                           int = map_to_int)
  
  # Change g1 vertex names.
  vertex.attributes(g1)$name <- left_join(data.frame(word = vertex.attributes(g1)$name), map_to_int, by = "word") %>% 
    select(int) %>% pull()
  
  # Change g2 vertex names.
  vertex.attributes(g2)$name <- left_join(data.frame(word = vertex.attributes(g2)$name), map_to_int, by = "word") %>% 
    select(int) %>% pull()
  
  return(list(g1,g2))
}


### Worked Example -- not functionized ###
# g1 <- reddit_graphs_s[[1]][[1]]
# g2 <- reddit_graphs_s[[2]][[1]]
# 
# v.g1 <- unlist(get.vertex.attribute(g1))
# v.g2 <- unlist(get.vertex.attribute(g2))
# 
# unique(c(v.g1,v.g2))
# 
# map_to_int <- seq(1,length(unique(c(v.g1,v.g2))))
# 
# map_to_int <- data.frame(word = unique(unique(c(v.g1,v.g2))),
#                          int = map_to_int)
# 
# vertex.attributes(g1)$name <- left_join(data.frame(word = vertex.attributes(g1)$name), map_to_int, by = "word") %>% 
#   select(int) %>% pull()
# 
# vertex.attributes(g2)$name <- left_join(data.frame(word = vertex.attributes(g2)$name), map_to_int, by = "word") %>% 
#   select(int) %>% pull()
# 
# CalculateVertexHistKernel(list(g1,g2))
# CalculateVertexHistKernel(list(reddit_graphs_s[[1]][[1]],
#                                reddit_graphs_s[[2]][[1]]))



