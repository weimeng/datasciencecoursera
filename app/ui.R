library(shiny)

shinyUI(fluidPage(

  titlePanel("Identification of iris species"),

  sidebarLayout(
    sidebarPanel(
      titlePanel("Petal"),
      sliderInput("Petal.Length",
                  "Length (in cm):",
                  min = 0,
                  max = 7.0,
                  value = 0,
                  step = 0.1),
      sliderInput("Petal.Width",
                  "Width (in cm):",
                  min = 0,
                  max = 2.5,
                  value = 0,
                  step = 0.1),
      titlePanel("Sepal"),
      sliderInput("Sepal.Length",
                  "Length (in cm):",
                  min = 0,
                  max = 8.0,
                  value = 0,
                  step = 0.1),
      sliderInput("Sepal.Width",
                  "Width (in cm):",
                  min = 0.0,
                  max = 5.0,
                  value = 0,
                  step = 0.1)
    ),

    mainPanel(
      h2("Instructions"),
      tags$ol(
        tags$li("Enter the petal and sepal measurements of your iris species in the left panel"),
        tags$li("Wait for the server to perform prediction"),
        tags$li("View your results below")),
      h2("Results"),
      tags$p("Based on the measurements you've entered on the left, your iris species is ",
             tags$strong("Iris ",
                         textOutput("prediction", inline = TRUE)),
             ".")
    )
  )
))
