# Download the data ----

# File is very large, 548 mb
if(!file.exists("data/raw/Coursera-SwiftKey.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
    download.file(url = url, destfile = "data/raw/Coursera-SwiftKey.zip" )
}

# Load the data ----
library(data.table)
df_twitter <- fread("data/raw/en_US.twitter.txt", nrows = 100, sep = NULL); df_twitter
df_news <- fread("data/raw/en_US.news.txt", nrows = 100, sep = NULL); df_news
df_blog <- fread("data/raw/en_US.blogs.txt", nrows = 100, sep = NULL); df_blog
