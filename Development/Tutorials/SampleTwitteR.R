# Sample File

library(twitteR)

# Search String
politics_sample <- twitteR::searchTwitter("Politics", n = 50)
head(politics_sample)

# Search User
hadley <- getUser("hadleywickham")
hadley$description
hadley$followersCount
hadley$getFollowers(n = 100)



