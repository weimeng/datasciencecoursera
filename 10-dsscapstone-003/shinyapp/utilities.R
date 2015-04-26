characterCleanup <- function(character) {
  character <- iconv(character, from = "latin1", to = "ASCII", sub = "")
  character <- tolower(character)
  character <- removePunctuation(character)
  character <- removeNumbers(character)
  character <- stripWhitespace(character)
  return(character)
}