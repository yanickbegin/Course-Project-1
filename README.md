##Course-Project-1
================

##Getting and Cleaning data

###Introduction

The purpose of this project is to deliver a tidy data set based on data collected from the accelerometers from the Samsung Galaxy S smartphone.

# Step 1 -  Constructing initial data frames
The data has been subdivised into 2 sets of data:  test and train.
Activity and subject labels are given in separate files.  It is necessary to merge these data as to get complete data set with appropriate label.  The following code does that:

<!-- -->

{
fileSubjectTest <- "./UCI HAR Dataset/test/subject_test.txt"
fileXTest <- "./UCI HAR Dataset/test/X_test.txt"
fileYTest <- "./UCI HAR Dataset/test/Y_test.txt"
fileActivityLabels <- "./UCI HAR Dataset/activity_labels.txt"
fileFeatures <- "./UCI HAR Dataset/features.txt"


subjectTest <- read.table(fileSubjectTest, col.names = "subjectID")
colNamesAL <- c("activityID", "activityLabels")
activityLabels <- read.table(fileActivityLabels, col.names = colNamesAL)
colNamesF <- c("featureID", "featureLabel")
features <- read.table(fileFeatures, col.names = colNamesF)

}
