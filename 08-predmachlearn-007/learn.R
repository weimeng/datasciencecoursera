library(caret)

data_train <- read.csv("./data/pml-training.csv", na.strings = c("", "#DIV/0!", "NA"))

clean_data <- function(data) {
  cleaned_data <- data[8:length(data)]

  cleaned_data_NAs <- apply(cleaned_data, 2, function(x) { sum(is.na(x)) })
  cleaned_data <- cleaned_data[, which(cleaned_data_NAs == 0)]
}

data_train_clean <- clean_data(data_train)

train_index <- createDataPartition(data_train_clean$classe, p = 0.7, list = FALSE)
training <- data_train_clean[train_index, ]
testing <- data_train_clean[-train_index, ]

model <- randomForest(classe ~ ., data = training)
prediction <- predict(model, testing)
confusionMatrix(testing$classe, prediction)

# data_test <- read.csv("./data/pml-testing.csv", na.strings = c("", "#DIV/0!", "NA"))
# data_test_clean <- clean_data(data_test)
