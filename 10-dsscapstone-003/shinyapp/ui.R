library(shiny)

shinyUI(fluidPage(
  titlePanel("the title"),
  
  textInput("inputString", "Start Typing:", "Start typing..."),
  
  code(textOutput("nextWord", inline = TRUE))
))