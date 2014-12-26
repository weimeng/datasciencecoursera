---
title       : "Iris species identification app"
author      : "Wei-Meng Lee"
date        : "21 December 2014"
framework   : io2012
highlighter : highlight.js
mode        : selfcontained
---

## Introduction

**Problem**

If you're new to the world of botany, identifying one species of plant from
another can be difficult. An app which asks for some basic measurements of parts
from a plant specimen and then identifies the species may be helpful.

**Solution**

A proof of concept app was created using Edgar Anderson's iris data. The user
inputs the iris specimen's petal length and width and the sepal length and 
width. The app then uses a predictive model to determine the species of the iris
specimen.

---

## Methodology

The app uses R's `caret` and `randomForest` libraries to fit a predictive model 
using random forestsclassification on Edgar Anderson's iris data set.




```r
data(iris)
model <- train(Species ~ ., data = iris)
```

The sepal length, sepal width, petal length and petal width can then be fed into
the predictive model to return an identification of the iris specimen's species.
An example is shown below:


```r
data <- data.frame(Sepal.Length = 4,
                   Sepal.Width = 2,
                   Petal.Length = 1.5,
                   Petal.Width = 3)

as.character(predict(model, data))
```

```
## [1] "setosa"
```

---

## The App

Of course, getting amateur botanists and other plant lovers to learn R just to 
run predictive models would be unrealistic. That's why I've packaged the code
on the previous slide into a simple proof-of-concept web application.

The application may be accessed at http://weimeng.shinyapps.io/devdataprod-016.

Alternatively, you may also go on to the next slide to access the app as it has
been embedded into the presentation.

---

## Try it out now!

<iframe src="http://weimeng.shinyapps.io/devdataprod-016"></iframe>
