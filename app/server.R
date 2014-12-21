library(shiny)
library(e1071)
library(caret)
library(randomForest)

data(iris)
model <- train(Species ~ ., data = iris)

shinyServer(function(input, output) {
  Prediction <- reactive({
    data <- data.frame(Sepal.Length = input$Sepal.Length,
                       Sepal.Width  = input$Sepal.Width,
                       Petal.Length = input$Petal.Length,
                       Petal.Width  = input$Petal.Width)
    prediction <- as.character(predict(model, data))
  })

  output$prediction <- renderText({
    Prediction()
  })
})
