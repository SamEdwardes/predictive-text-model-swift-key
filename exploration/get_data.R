library(quanteda)
library(readtext)

# Download the data ----

# File is very large, 548 mb
if(!file.exists("data/raw/Coursera-SwiftKey.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
    download.file(url = url, destfile = "data/raw/Coursera-SwiftKey.zip" )
}

# Load the data ----
# library(data.table)
# df_twitter <- fread("data/raw/en_US.twitter.txt", nrows = 100, sep = NULL); df_twitter
# df_news <- fread("data/raw/en_US.news.txt", nrows = 100, sep = NULL); df_news
# df_blog <- fread("data/raw/en_US.blogs.txt", nrows = 100, sep = NULL); df_blog

# quanteda ----

# summary(corpus(data_char_ukimmig2010))

# read text
news <- readtext("data/raw/en_US.news.500.txt")
blogs <- readtext("data/raw/en_US.blogs.500.txt")
twitter <- readtext("data/raw/en_US.twitter.500.txt")

# read all data
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


# combine all the corps
corp <- news_corp + blogs_corp + twitter_corp
# segment based on \n
corp <- corpus_segment(corp, pattern = "\n"); 
summary(corp)

# explorting the corpus ----

# extract text 
texts(corp)[1:2]

# find text
kwic(corp, pattern = "today")

head(docvars(corp))

# dfm()
dfmat <- dfm(corp)



