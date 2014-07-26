#
# STEP 1:
# Merge the training and the test sets to create one data set.
#
# Note: This step assumes that the project data has been downloaded and
# extracted to the "./UCI HAR Dataset" directory.

testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt")
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testSet <- cbind(testSubjects, testActivities, testData)

trainingSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainingActivities <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainingData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainingSet <- cbind(trainingSubjects, trainingActivities, trainingData)

totalSet <- rbind(testSet, trainingSet)

#
# STEP 2:
# Extract only the measurements on the mean and standard deviation for each
# measurement.
#

dataLabels <- read.table("./UCI HAR Dataset/features.txt")$V2
# https://class.coursera.org/getdata-005/forum/thread?thread_id=23#comment-753
dataLabels <- gsub("BodyBody", "Body", dataLabels)
dataLabels <- gsub("\\(\\)", "", dataLabels)
dataLabels <- append(c("Subject", "Activity"), dataLabels)
names(totalSet) <- dataLabels

wantedColumns <- grep("-mean-|-mean$|std", names(totalSet))
wantedColumns <- append(c(1, 2), wantedColumns)

wantedSet <- totalSet[wantedColumns]

#
# STEP 3:
# Use descriptive activity names to name the activities in the data set
#

wantedSet$Activity <- as.factor(wantedSet$Activity)
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")$V2
levels(wantedSet$Activity) <- activityLabels

#
# Step 4:
# Appropriately label the data set with descriptive variable names.
#

names(wantedSet) <- gsub("^t", "Time", names(wantedSet))
names(wantedSet) <- gsub("^f", "Frequency", names(wantedSet))

names(wantedSet) <- gsub("Acc", "Accelerometer", names(wantedSet))
names(wantedSet) <- gsub("Gyro", "Gyrometer", names(wantedSet))

names(wantedSet) <- gsub("mean", "Mean", names(wantedSet))
names(wantedSet) <- gsub("std", "Std", names(wantedSet))

#
# Step 5:
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject.
#

library(reshape2)

wantedMelt <- melt(wantedSet, id = c("Subject", "Activity"),
                           measure.vars = names(wantedSet)[-c(1, 2)])

tidySet <- dcast(wantedMelt, Subject + Activity ~ variable, mean)


if (file.exists("./tidydata.csv")) { unlink("./tidydata.csv") }
tidyData <- file("./tidydata.csv", "w")
write.csv(tidySet, file=tidyData)
close(tidyData)
