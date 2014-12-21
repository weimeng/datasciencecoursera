library(shiny)

shinyUI(fluidPage(

  titlePanel("Identification of iris species"),

  sidebarLayout(
    sidebarPanel(
      titlePanel("Petal"),
      sliderInput("Petal.Length",
                  "Length:",
                  min = 1.0,
                  max = 7.0,
                  value = 3.0,
                  step = 0.1),
      sliderInput("Petal.Width",
                  "Width:",
                  min = 0.1,
                  max = 2.5,
                  value = 1.3,
                  step = 0.1),
      titlePanel("Sepal"),
      sliderInput("Sepal.Length",
                  "Length:",
                  min = 4.0,
                  max = 8.0,
                  value = 5.8,
                  step = 0.1),
      sliderInput("Sepal.Width",
                  "Width:",
                  min = 2.0,
                  max = 5.0,
                  value = 3.0,
                  step = 0.1)
    ),

    mainPanel(
      textOutput("prediction")
    )
  )
))
