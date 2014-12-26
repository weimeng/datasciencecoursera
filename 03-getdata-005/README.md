Getting and Cleaning Data: Course Project
=========================================
This repository contains my course project for Cleaning and Getting Data, a
Coursera course offered by the John Hopkins University as part of the Data
Science Specialization.

The purpose of this project is to demonstrate my ability to collect, work with,
and clean a data set. The goal is to prepare tidy data that can be used for
later analysis.

Pre-requisites
--------------
You should have downloaded the project data and extracted it into a directory in
named `UCI HAR Dataset`  in the repository's root.

As of 27 July 2014, the project data can be downloaded from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original source of the data is:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

run_analysis.R
--------------
The `run_analysis.R` script is designed to read the project data above and:

1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each
   measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. Create a second, independent tidy data set in a `tidydata.txt` file with the
   average of each variable for each activity and each subject.

The resulting `tidydata.txt` file can be read using the `read.table` function
in R.

The `run_analysis.R` script is well-documented and there are in-line comments
which explain each step taken to transform the data. Please view the file for
further details.

Codebook
--------
A codebook accompanies the `run_analysis.R` script and describes the data which
can be found in `tidydata.txt`. Please refer to `codebook.MD` for more details.
