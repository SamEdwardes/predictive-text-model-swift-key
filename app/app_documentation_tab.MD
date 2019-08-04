## Background

The text prediction model is an ngram language model that analyses text to predict what the next word should be. The algorithm will predict what word it thinks you wish to type next.

## About the model

The model was built as part of the JHU Coursera Datascience Capstone project. At a high level, the model works as follows:

**1. Develop ngram model** 

- Using [training data](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip) that contains text from twitter, blogs, and news sites, a coprus was developed. To keep the model lightweight, only a small percentage of randomly selected data was used for training.
- The training text was pre-processed to remove any characters that were non-alpha (e.g. a, b, c, etc.).
- The training text was tokenized and further processed in an attempt to normalize the data to get the most our of our smaller training set.
- Ngrams ranging from a size of 1 to 4 were created, and then transformed into a datafeature matrix (DFM). The DFM counted the frequency that each ngram occured with.

**2. Predicting the next word**

The prediction algorithm considers the last 3 words that have been typed in order to generate a prediction. To predict the next word, an approach similar to the so called *Stupid Backoff* was used (this approach was selected as it is easier to understand, however it may not produce the most accurate result):

- first, 

## Resources

Project:

- [GitHub Repo](https://github.com/SamEdwardes/predictive-text-model-swift-key)
- [Data](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip)
[JHU Coursera Capstone](https://www.coursera.org/learn/data-science-project)
- [Training data](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip)

Ngram models:

- [Predicting Next Word Using Katz Back-Off](https://rpubs.com/mszczepaniak/predictkbo3model)
- [Large Language Models in Machine Translation (Stupid Backoff)](http://www.aclweb.org/anthology/D07-1090.pdf) *note this link will download a pdf document*
- [Katz’s Backoff Model Implementation in R](https://thachtranerc.wordpress.com/2016/04/12/katzs-backoff-model-implementation-in-r/)
- [Beginers guide to quanteda](https://data.library.virginia.edu/a-beginners-guide-to-text-analysis-with-quanteda/)
- [Text mining infrastucture in R](http://www.jstatsoft.org/v25/i05/)
- [CRAN Task View: Natural Language Processing](http://cran.r-project.org/web/views/NaturalLanguageProcessing.html)
- [Videos](https://www.youtube.com/user/OpenCourseOnline/search?query=NLP) and [Slides](https://web.stanford.edu/~jurafsky/NLPCourseraSlides.html) from Stanford Natural Language Processing course
