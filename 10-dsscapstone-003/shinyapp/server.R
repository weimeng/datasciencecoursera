library(shiny)
library(tm)

unigrams <- readRDS("unigrams_short.rds")
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

predictUnigram <- function() {
  results <- names(head(unigrams))
  return(results)
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
  
  splitString <- strsplit(cleanedString, " ")[[1]]
  
  nextWord <- c()
  
  if(numberOfWords == 0) {
    nextWord <- "Start typing to get started!"
  }
  
  if(numberOfWords > 2) {
    cleanedString <- splitString[(length(splitString) - 1):length(splitString)]
    cleanedString <- paste(cleanedString, collapse = " ")
    nextWord <- predictTrigram(cleanedString)
  }
  
  if(numberOfWords == 2) {
    nextWord <- predictTrigram(cleanedString)
  }
  
  if(length(nextWord) == 0) {
    cleanedString <- splitString[(length(splitString))]
    nextWord <- predictBigram(cleanedString)
  }
  
  if(length(nextWord) == 0) {
    nextWord <- predictUnigram()
  }

  return(nextWord)
}

shinyServer(function(input, output) {
  Suggestion <- reactive({
    predictNextWord(input$inputString)
  })  
  
  output$nextWord_1 <- renderText({Suggestion()[1]})
  output$nextWord_2 <- renderText({Suggestion()[2]})
  output$nextWord_3 <- renderText({Suggestion()[3]})
  output$nextWord_4 <- renderText({Suggestion()[4]})
  output$nextWord_5 <- renderText({Suggestion()[5]})
})