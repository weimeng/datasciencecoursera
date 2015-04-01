library(tm)
library(RWeka)
library(slam)

# Set this so RWeka plays nice with multicores
options(mc.cores=1)

twitter.filename <- "./data/final/en_US/en_US.twitter.txt"
blogs.filename <- "./data/final/en_US/en_US.blogs.txt"
news.filename <- "./data/final/en_US/en_US.news.txt"

twitter.sample.filename <- "./data/sample/en_US/en_US.twitter.txt"
blogs.sample.filename <- "./data/sample/en_US/en_US.blogs.txt"
news.sample.filename <- "./data/sample/en_US/en_US.news.txt"

# Set seed for reproducibility
set.seed(42)

sampleCorpus <- function(corpus) {
  corpus.sample.nlines <- length(corpus) * 0.05
  corpus.sample <- sample(corpus, corpus.sample.nlines)
  return(corpus.sample)
}

#
# Process Twitter data
#

# Read Twitter final data
twitter.data.con <- file(twitter.filename, "r")
twitter <- readLines(twitter.data.con)
close(twitter.data.con)

# Prepare Twitter sample data
twitter.sample.con <- file(twitter.sample.filename, "w")

# Get 5% of total data as subset
twitter.sample <- sampleCorpus(twitter)

# Write Twitter sample data
writeLines(twitter.sample, twitter.sample.con)
close(twitter.sample.con)

# #
# # Process blogs data
# #
# 
# # Read blogs final data
# blogs.data.con <- file(blogs.filename, "r")
# blogs <- readLines(blogs.data.con)
# close(blogs.data.con)
# 
# # Prepare blogs sample data
# blogs.sample.con <- file(blogs.sample.filename, "w")
# 
# # Get 5% of total data as subset
# blogs.nlines <- length(blogs)
# blogs.sample.nlines <- blogs.nlines * 0.05
# blogs.sample <- sample(blogs, blogs.sample.nlines)
# 
# # Write blogs sample data
# writeLines(blogs.sample, blogs.sample.con)
# close(blogs.sample.con)
# 
# #
# # Process news data
# #
# 
# # Read news final data
# news.data.con <- file(news.filename, "r")
# news <- readLines(news.data.con)
# close(news.data.con)
# 
# # Prepare news sample data
# news.sample.con <- file(news.sample.filename, "w")
# 
# # Get 5% of total data as subset
# news.nlines <- length(news)
# news.sample.nlines <- news.nlines * 0.05
# news.sample <- sample(news, news.sample.nlines)
# 
# # Write news sample data
# writeLines(news.sample, news.sample.con)
# close(news.sample.con)

corpusCleanup <- function(corpus) {
  corpus <- tm_map(corpus, content_transformer(iconv), from = "latin1", to = "ASCII", sub = "")
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removeNumbers)
  return(corpus)
}

twitter.corpus <- Corpus(VectorSource(twitter.sample))
twitter.corpus <- corpusCleanup(twitter.corpus)

UnigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
twitter.unigrams <- TermDocumentMatrix(twitter.corpus, control = list(tokenize = UnigramTokenizer))
twitter.unigrams.freq <- sort(row_sums(twitter.unigrams), decreasing = TRUE)
barplot(twitter.unigrams.freq[1:20], col=rainbow(20), las=2)