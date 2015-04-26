library(shiny)
library(tm)

# unigrams <- readRDS("unigrams.rds")
bigrams <- readRDS("bigrams.rds")
trigrams <- readRDS("trigrams.rds")

characterCleanup <- function(character) {
  character <- iconv(character, from = "latin1", to = "ASCII", sub = "")
  character <- tolower(character)
  character <- removePunctuation(character)
  character <- removeNumbers(character)
  character <- stripWhitespace(character)
  return(character)
}

predictBigram <- function(input) {
  grepString <- paste("^", input, sep = "")  
  results <- names(head(bigrams[grep(grepString, names(bigrams))]))  
  suggestions <- unlist(lapply(results, FUN = function (x) strsplit(x, " ")[[1]][2]))  
  return(suggestions)
}

predictTrigram <- function(input) {
  grepString <- paste("^", input, sep = "")
  results <- names(head(trigrams[grep(grepString, names(trigrams))]))  
  suggestions <- unlist(lapply(results, FUN = function (x) strsplit(x, " ")[[1]][3]))  
  return(suggestions)
}

predictNextWord <- function(inputString) {
  cleanedString <- characterCleanup(inputString)
  
  if(cleanedString == " " | cleanedString == "") {
    numberOfWords <- 0
  } else {
    numberOfWords <- sapply(gregexpr("\\b\\W+\\b", cleanedString, perl = TRUE), function(x) sum(x>0) ) + 1    
  }
  
  matchString <- paste("^", cleanedString, "$", sep = "")
  
  if(numberOfWords == 0) {
    nextWord <- "Please type some words in for prediction"
  } else if(numberOfWords == 1) {
    nextWord <- predictBigram(cleanedString)
  } else if(numberOfWords >= 2) {
    nextWord <- predictTrigram(cleanedString)
  } else {
    nextWord <- "Placeholder..."  
  }
  
  return(nextWord)
}

shinyServer(function(input, output) {
  Suggestion <- reactive({
    predictNextWord(input$inputString)
  })  
  
  output$nextWord <- renderText({
    Suggestion()
  })
})