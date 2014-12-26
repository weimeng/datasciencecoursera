data(iris)
model <- train(Species ~ ., data = iris)

data <- data.frame(Sepal.Length = 4,
                   Sepal.Width = 2,
                   Petal.Length = 1.5,
                   Petal.Width = 3)

prediction <- predict(model, data)
