predictBigram <- function(input) {
  grepString <- paste("^", "input", sep = "")
  
  results <- names(head(bigrams[grep(grepString, names(bigrams))]))
  
  suggestions <- unlist(lapply(result, FUN = function (x) strsplit(x, " ")[[1]][2]))
  
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
  } else if(numberOfWords >= 3) {
    nextWord <- "Trigram"
  } else {
    nextWord <- "Placeholder..."  
  }
  
  return(nextWord)
}