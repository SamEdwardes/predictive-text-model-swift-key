# Download the data ----

# File is very large, 548 mb
if(!file.exists("data/raw/Coursera-SwiftKey.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
    download.file(url = url, destfile = "data/raw/Coursera-SwiftKey.zip" )
}

# Load teh data ----
