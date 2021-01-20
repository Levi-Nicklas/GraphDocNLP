# Process into Graph Objects
# Levi C. Nicklas
# Date: 12/19/2020
#
#
# Notes:  This script features a function which takes .. <what am I feeding this bad boy?> ...
#         and returns a list of graph representations of the text file.

df_to_graph_list <- function(text){
  # Check libraries
  require(dplyr)
  require(tidyr)
  require(tidytext)
  require(igraph)
  
  n_gram <- 2
  k_skip <- 2
  
  # Prepare variables and space.
  text_df <- as.data.frame(text)
  colnames(text_df) <- c("text")
  text_df$id <- seq(1,nrow(text_df))
  graph_list <- list()
  
  # Loop over rows in data.
  for(i in 1:nrow(text_df)){
    # tokenize as skip grams.
    temp_df <- tidytext::unnest_tokens(text_df, 
                                       output = "words" ,
                                       input = text, 
                                       token = "skip_ngrams",
                                       n = n_gram,
                                       k = k_skip) %>%  
      # filter to only 1 document.
      dplyr::filter(id == i) %>% 
      # split bigram
      tidyr::separate(words, c("word1", "word2"), sep = " ") %>%
      # toss NA values.
      tidyr::drop_na() %>% 
      # group each bigram.
      group_by(word1, word2) %>% 
      # count occurances.
      count() %>% 
      # produce Graph.
      igraph::graph_from_data_frame()
    
    # Store
    graph_list[[i]] <- list(temp_df, text)
  }

  # Return a list of Graphs  
  return(graph_list)
  
}
