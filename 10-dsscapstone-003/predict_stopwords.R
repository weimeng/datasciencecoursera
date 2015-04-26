library(tm)
library(RWeka)
library(slam)

# Set this so RWeka plays nice with multicores
options(mc.cores=1)

twitter.sample.filename <- "./data/sample/en_US/en_US.twitter.txt"
blogs.sample.filename <- "./data/sample/en_US/en_US.blogs.txt"
news.sample.filename <- "./data/sample/en_US/en_US.news.txt"
profanity.filename <- "./data/profanity/shutterstock_en.txt"

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

# Read profanity data
profanity.con <- file(profanity.filename, "r")
profanity <- readLines(profanity.con)
close(profanity.con)

# Combine all sample data
all <- c(blogs, news, twitter)

characterCleanup <- function(character) {
  character <- iconv(character, from = "latin1", to = "ASCII", sub = "")
  character <- tolower(character)
  character <- removePunctuation(character)
  character <- removeNumbers(character)
  character <- removeWords(character, profanity)
  character <- removeWords(character, stopwords("english"))
  character <- stripWhitespace(character)
}

all.sanitized <- characterCleanup(all)

all.corpus <- Corpus(VectorSource(all.sanitized))

UnigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))

all.unigrams <- TermDocumentMatrix(all.corpus, control = list(tokenize = UnigramTokenizer))
all.bigrams <- TermDocumentMatrix(all.corpus, control = list(tokenize = BigramTokenizer))
all.trigrams <- TermDocumentMatrix(all.corpus, control = list(tokenize = TrigramTokenizer))

all.unigrams.freq <- sort(row_sums(all.unigrams), decreasing = TRUE)
all.bigrams.freq <- sort(row_sums(all.bigrams), decreasing = TRUE)
all.trigrams.freq <- sort(row_sums(all.trigrams), decreasing = TRUE)
