library(quanteda)
library(readtext)
library(tidyverse)

# Q1 - How big is the us blogs file? ----

# Answer: 200 + mb

# read all data
news_big <- readtext("data/raw/en_US.news.txt")
blogs_big <- readtext("data/raw/en_US.blogs.txt")
twitter_big <- readtext("data/raw/en_US.twitter.txt")

# create corpus
news_corp <- corpus(news_big)
blogs_corp <- corpus(blogs_big)
twitter_corp <- corpus(twitter_big)

# Q2 - how many lines does the twitter text have? ----

# segment the corpus to lines

news_corp <- corpus_segment(news_corp, pattern = "\n")
blogs_corp <- corpus_segment(blogs_corp, pattern = "\n")
twitter_corp <- corpus_segment(twitter_corp, pattern = "\n")

summary(twitter_corp, n=5)

# Answer: 2,360,147

# Q3 - what is the length of the longest line in the 3 data sets ----

corp <- corpus_segment(corp, pattern = "\n")

# calcualte length and add to corpus
len <- sapply(texts(corp), nchar)
docvars(corp, "Length") <- len

# find the longest
head(sort(len, decreasing = TRUE))

# Answer: 40,835 from en_us.blogs

# Q4: in the twitter data set, if you divide the number of lines where the word "love" (all lowercase) ----
# occurs by the number of lines the word ("hate") all lowercase occurs what about do you get?

# kwic(twitter_corp, pattern = "love")
love <- sum(grepl(texts(twitter_corp), pattern = "love"))
hate <- sum(grepl(texts(twitter_corp), pattern = "hate"))
love/hate

# Answer: 4.1


# Q5 what does the "biostat" tweet say in the twitter data ----

# kwic(twitter_corp, pattern = "biostat")

texts(twitter_corp)[grepl(texts(twitter_corp), pattern = "biostat")]

# Answer:
# en_US.twitter.txt.556871 
# "i know how you feel.. i have biostats on tuesday and i have yet to study =/"


# Q6 How many tweets have the exact characters ----
# "A computer once beat me at chess, but it was no match for me at kickboxing". 
# (I.e. the line matches those characters exactly.)

sum(grepl(texts(twitter_corp), 
          pattern = "A computer once beat me at chess, but it was no match for me at kickboxing"))

texts(twitter_corp)[grepl(texts(twitter_corp), 
                          pattern = "A computer once beat me at chess, but it was no match for me at kickboxing")]

# Answer: 3

