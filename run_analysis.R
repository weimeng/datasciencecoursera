#
# STEP 1:
# Merge the training and the test sets to create one data set.
#
# Note: This step assumes that the project data has been downloaded and
# extracted to the "./UCI HAR Dataset" directory.

# Prepare test data
testSubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
testActivities <- read.table("./UCI HAR Dataset/test/y_test.txt")
testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
testSet <- cbind(testSubjects, testActivities, testData)

# Prepare training data
trainingSubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
trainingActivities <- read.table("./UCI HAR Dataset/train/y_train.txt")
trainingData <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainingSet <- cbind(trainingSubjects, trainingActivities, trainingData)

# Merge test and training data
totalSet <- rbind(testSet, trainingSet)

#
# STEP 2:
# Extract only the measurements on the mean and standard deviation for each
# measurement.
#

# Read data labels so we know which columns to extract
dataLabels <- read.table("./UCI HAR Dataset/features.txt")$V2

# Fix typo present in original data set. Please see:
# https://class.coursera.org/getdata-005/forum/thread?thread_id=23#comment-753
dataLabels <- gsub("BodyBody", "Body", dataLabels)

# Remove brackets
dataLabels <- gsub("\\(\\)", "", dataLabels)

# Add labels for Subject and Activity columns
dataLabels <- append(c("Subject", "Activity"), dataLabels)

# Apply labels to combined data set
names(totalSet) <- dataLabels

# Determine the columns which we want. Explanation of regular expressions:

# Get standard deviations:
#   std    => Match columns whose name contains "std".

# Get means:
#   -mean- => Match columns whose name contains "-mean-"
#   -mean$ => Match columns whose name ends with "-mean"
#
#   Note: These two regexes are used to avoid selecting "meanFreq", which should
#   be excluded from the data set. Please see the following link for discussion:
#   https://class.coursera.org/getdata-005/forum/thread?thread_id=180#comment-568

wantedColumns <- grep("std|-mean-|-mean$", names(totalSet))
wantedColumns <- append(c(1, 2), wantedColumns)

# Apply subset to get only mean and standard deviations
wantedSet <- totalSet[wantedColumns]

#
# STEP 3:
# Use descriptive activity names to name the activities in the data set
#

# Convert activity values to factors
wantedSet$Activity <- as.factor(wantedSet$Activity)

# Get activity names
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")$V2

# Apply activity names to factor levels
levels(wantedSet$Activity) <- activityLabels

#
# Step 4:
# Appropriately label the data set with descriptive variable names.
#

# Make it clearer which domain the measurements are made in
names(wantedSet) <- gsub("^t", "Time", names(wantedSet))
names(wantedSet) <- gsub("^f", "Frequency", names(wantedSet))

# Make it clearer what the source of the measurements were
names(wantedSet) <- gsub("Acc", "Accelerometer", names(wantedSet))
names(wantedSet) <- gsub("Gyro", "Gyrometer", names(wantedSet))
names(wantedSet) <- gsub("Mag", "Magnitude", names(wantedSet))

# Make cases consistent with rest of label
names(wantedSet) <- gsub("mean", "Mean", names(wantedSet))
names(wantedSet) <- gsub("std", "Std", names(wantedSet))

#
# Step 5:
# Create a second, independent tidy data set with the average of each variable
# for each activity and each subject.
#

library(reshape2)

# Melt and recast our data
wantedMelt <- melt(wantedSet, id = c("Subject", "Activity"),
                           measure.vars = names(wantedSet)[-c(1, 2)])
tidySet <- dcast(wantedMelt, Subject + Activity ~ variable, mean)

# Check if tidydata.csv exists. If it does, delete it.
if (file.exists("./tidydata.csv")) { unlink("./tidydata.csv") }

# Write tidy data to tidydata.csv file
tidyData <- file("./tidydata.csv", "w")
write.csv(tidySet, file=tidyData)
close(tidyData)
