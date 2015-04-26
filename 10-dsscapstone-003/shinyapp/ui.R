library(shiny)

shinyUI(fluidPage(
  tags$head(
    tags$link(href="stylesheet.css", rel="stylesheet"),
    tags$script(src="suggestions.js")
  ),
  
  titlePanel("Coursera Data Science Specialisation Final Project App"),
  
  wellPanel(id = "messageWell",
    p(class = "received message", "Hello! Welcome to my final project for the Coursera-Johns Hopkins Data Science Specialisation Capstone module."),
    p(class = "received message", "This Shiny app allows for simple next-word text prediction. Simply start typing in the text box below to get started."),
    p(class = "received message", "You may click on any of the five suggested words below the text box to instantly add it to your sentence. Try it!"),
    p(class = "received message", "When you're done typing, click on 'Send Message' to send your message!")
  ),
  textInput("inputString", "Start Typing:", "Start typing..."),
  
  wellPanel(id = "next-word-suggestions",
    p("Suggested next word (in order of priority):"),
    
    tags$ol(
      tags$li(
        a(
          href = "#",
          class = "nextWordSuggest",
          textOutput("nextWord_1")
        )
      ),
      tags$li(
        a(
          href = "#",
          class = "nextWordSuggest",
          textOutput("nextWord_2")
        )
      ),
      tags$li(
        a(
          href = "#",
          class = "nextWordSuggest",
          textOutput("nextWord_3")
        )
      ),
      tags$li(
        a(
          href = "#",
          class = "nextWordSuggest",
          textOutput("nextWord_4")
        )
      ),
      tags$li(
        a(
          href = "#",
          class = "nextWordSuggest",
          textOutput("nextWord_5")
        )
      )
    )
  ),
  actionButton("sendMessage", "Send Message")
))