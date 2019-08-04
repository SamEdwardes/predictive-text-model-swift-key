# Environment ----
library(quanteda)
library(readtext)
library(tidyverse)

# get other functions
source("app/prediction_functions.R")

# set working directory
if(Sys.info()["sysname"] == "Windows"){ # working directory for my windows machine
    setwd("~/GitHub/predictive-text-model-swift-key")
} else { # working directory for my Macbook Pro
    setwd("~/Documents/GitHub/predictive-text-model-swift-key")
}

# Read data ----

news_big <- readtext("data/raw/en_US.news.txt")
blogs_big <- readtext("data/raw/en_US.blogs.txt")
twitter_big <- readtext("data/raw/en_US.twitter.txt")

# create corpus
news_corp <- corpus(news_big)
blogs_corp <- corpus(blogs_big)
twitter_corp <- corpus(twitter_big)

# segment the corpus to lines
news_corp <- corpus_segment(news_corp, pattern = "\n")
blogs_corp <- corpus_segment(blogs_corp, pattern = "\n")
twitter_corp <- corpus_segment(twitter_corp, pattern = "\n")

# add all corpus together
all_corp <- news_corp + blogs_corp + twitter_corp

rm(news_corp, blogs_corp, twitter_corp,
   news_big, blogs_big, twitter_big)


# clean_corpus
# returns: a corpus object with "cleaned" text, such that we have removed all characters that are not A:Z
# arguments: 
#   - corp = corpus object from quanteda
clean_corpus <- function(corp){
    # remove anything that is not alpha or number
    texts(corp) <- stringr::str_replace_all(texts(corp),"[^a-zA-Z\\s]", "")
    return(corp)
}


# Training and testing data ----

pop_size <- length(all_corp$documents$texts)

# define training data
set.seed(2019-07-24)
train_corp <- corpus_sample(all_corp, size = pop_size * 0.01)
train_corp <- clean_corpus(train_corp)

# define testing data
set.seed(2019-07-25)
test_corp <- corpus_sample(all_corp, size = pop_size * 0.001)
test_corp <- clean_corpus(test_corp)


# Process tokens ----
train.tokens <- tokens(train_corp)
train.tokens <- process_tokens(train.tokens)


# Build the  model ----

# ** Ngrams ----
train.ngram1 <-tokens_ngrams(train.tokens, n = 1)
train.ngram2 <-tokens_ngrams(train.tokens, n = 2)
train.ngram3 <-tokens_ngrams(train.tokens, n = 3)
train.ngram4 <-tokens_ngrams(train.tokens, n = 4)

# ** DFM ----
# create a document feature matrix (dfm) for up to 4 ngrams
train.dfm1 <- textstat_frequency(dfm(train.ngram1))[,1:2]
train.dfm1$ngrams <- 1
train.dfm2 <- textstat_frequency(dfm(train.ngram2))[,1:2]
train.dfm2$ngrams <- 2
train.dfm3 <- textstat_frequency(dfm(train.ngram3))[,1:2]
train.dfm3$ngrams <- 3
train.dfm4 <- textstat_frequency(dfm(train.ngram4))[,1:2]
train.dfm4$ngrams <- 4

# combine all the dfms together
train.dfm <- rbind(train.dfm1, train.dfm2, train.dfm3, train.dfm4)

# Only keep n fetures with at least 2 observations
train.dfm <- train.dfm %>% filter(frequency >= 2)

# ** Check results ----
table(train.dfm$ngrams)
head(train.dfm, 20)

rm(train.dfm1, train.dfm2, train.dfm3, train.dfm4,
   train.ngram1, train.ngram2, train.ngram3, train.ngram4)

# END OF SCRIPT ----