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
    temp_graph <- tidytext::unnest_tokens(text_df, 
                                       output = "words" ,
                                       input = text, 
                                       token = "skip_ngrams",
                                       n = n_gram,
                                       k = k_skip) %>%  
      # filter to only 1 document.
      dplyr::filter(id == i) %>% 
      # split bigram
      tidyr::separate(words, c("word1", "word2"), sep = " ") %>%
      # remove stop words
      anti_join(stop_words, by = c("word1" = "word")) %>% 
      anti_join(stop_words, by = c("word2" = "word")) %>% 
      # toss NA values.
      tidyr::drop_na() %>% 
      # clean out punctuation %>% 
      mutate(word1_toss = stringr::str_detect(word1, "\\.")) %>% 
      mutate(word2_toss = stringr::str_detect(word2, "\\.")) %>% 
      mutate(toss_pair = word1_toss|word2_toss) %>% 
      filter(toss_pair == F) %>% 
      # clean out numebrs
      select(id,word1,word2) %>% 
      mutate(word1_toss = stringr::str_detect(word1,"[:digit:]")) %>% 
      mutate(word2_toss = stringr::str_detect(word2,"[:digit:]")) %>% 
      mutate(toss_pair = word1_toss|word2_toss) %>% 
      filter(toss_pair == F) %>% 
      select(id,word1,word2) %>% 
      # only keep words of > len 3
      mutate(word1_toss = (nchar(word1)<4)) %>% 
      mutate(word2_toss = (nchar(word2)<4)) %>% 
      mutate(toss_pair = word1_toss|word2_toss) %>% 
      filter(toss_pair == F) %>% 
      select(id, word1, word2) %>% 
      # group each bigram.
      group_by(word1, word2) %>% 
      # count occurances.
      count() %>% 
      # produce Graph.
      igraph::graph_from_data_frame()
    
    cleaned_words_df <- temp_graph %>% igraph::clusters()
    cleaned_words_df <- as.data.frame(cleaned_words_df$membership)
    cleaned_words_df$words <- rownames(cleaned_words_df)
    colnames(cleaned_words_df) <- c("member", "words")
    reduced_clusters <- cleaned_words_df %>% 
      filter(member != 1)
    
    # Get single largest cluster.
    big_graph <- temp_graph %>% 
      as_edgelist() %>% 
      as.data.frame() %>% 
      anti_join(y = reduced_clusters, by = c("V1" = "words")) %>% 
      anti_join(y = reduced_clusters, by = c("V2" = "words")) %>% 
      graph_from_data_frame()
    
    # Store
    graph_list[[i]] <- list(big_graph, text)
  }

  # Return a list of Graphs  
  return(graph_list)
  
}
