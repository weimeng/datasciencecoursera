library(tm)
library(RWeka)
library(slam)

# Set this so RWeka plays nice with multicores
options(mc.cores=1)

twitter.sample.filename <- "./data/sample/en_US/en_US.twitter.txt"
blogs.sample.filename <- "./data/sample/en_US/en_US.blogs.txt"
news.sample.filename <- "./data/sample/en_US/en_US.news.txt"

# Read blogs sample data
blogs.data.con <- file(blogs.sample.filename, "r")
blogs <- readLines(blogs.data.con)
close(blogs.data.con)

# Read news sample data
news.data.con <- file(news.sample.filename, "r")
news <- readLines(news.data.con)
close(news.data.con)

# Read Twitter sample data
twitter.data.con <- file(twitter.sample.filename, "r")
twitter <- readLines(twitter.data.con)
close(twitter.data.con)

# Combine all sample data
all <- c(blogs, news, twitter)

corpusCleanup <- function(corpus) {
  corpus <- tm_map(corpus, content_transformer(iconv), from = "latin1", to = "ASCII", sub = "")
  corpus <- tm_map(corpus, content_transformer(tolower))
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removeNumbers)
  return(corpus)
}

all.corpus <- Corpus(VectorSource(all))
all.corpus <- corpusCleanup(all.corpus)

UnigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))

all.unigrams <- TermDocumentMatrix(all.corpus, control = list(tokenize = UnigramTokenizer))
all.bigrams <- TermDocumentMatrix(all.corpus, control = list(tokenize = BigramTokenizer))
all.trigrams <- TermDocumentMatrix(all.corpus, control = list(tokenize = TrigramTokenizer))

all.trigrams.freq <- sort(row_sums(all.trigrams), decreasing = TRUE)