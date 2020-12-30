# partition the data.

for(i in 1:length(mentalhealth_reddit_20201025)){
  temp <- mentalhealth_reddit_20201025[[i]] 
  
  filename <- paste0("../../Data/RawData/subreddit-",i,".RDS")
  
  saveRDS(object = temp, filename)
  
  
}
