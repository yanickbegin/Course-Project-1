##  Getting and cleaning data - Course Project

##  Construct test data frame
##  For clarity, I put all files path in variables
fileSubjectTest <- "./UCI HAR Dataset/test/subject_test.txt"
fileXTest <- "./UCI HAR Dataset/test/X_test.txt"
fileYTest <- "./UCI HAR Dataset/test/Y_test.txt"
fileActivityLabels <- "./UCI HAR Dataset/activity_labels.txt"
fileFeatures <- "./UCI HAR Dataset/features.txt"

##  Create separate data frames for each file
subjectTest <- read.table(fileSubjectTest, col.names = "subjectID")
colNamesAL <- c("activityID", "activityLabels")
activityLabels <- read.table(fileActivityLabels, col.names = colNamesAL)
colNamesF <- c("featureID", "featureLabel")
features <- read.table(fileFeatures, col.names = colNamesF)

##  Renaming of features is necessary to get tidy data
features$featureLabel <- gsub("-", ".", features$featureLabel)
features$featureLabel <- gsub("\\()", "", features$featureLabel)
features$featureLabel <- gsub("Acc", "Accelerometer", features$featureLabel)
features$featureLabel <- gsub("Gyro", "Gyroscope", features$featureLabel)

##  Header of columns should be assign from features data frame
xTest <- read.table(fileXTest, col.names = features$featureLabel)
yTest <- read.table(fileYTest, col.names = "activityID")


##  Merge all data frames into 1 data frames
testFullDF<-cbind(subjectTest, yTest)
testFullDF<-merge(activityLabels, testFullDF)
testFullDF<-cbind(testFullDF, xTest)
testFullDF <- testFullDF[order(testFullDF$activityID, testFullDF$subjectID),]

##  Extract columns that contains mean, std and keep 3 first column
testMeansCol <- grep("mean", colnames(testFullDF))
testStdCol <- grep("std", colnames(testFullDF))
baseCol <- c(1, 2, 3)
testMeansStd <- sort(c(baseCol, testMeansCol, testStdCol))

##  Create new test data frame using only means and std columns
testDF <- testFullDF[,testMeansStd]
row.names(testDF)<-NULL


##  Construct train data frame
##  For clarity, I put all files path in variables
fileSubjectTrain <- "./UCI HAR Dataset/train/subject_train.txt"
fileXTrain <- "./UCI HAR Dataset/train/X_train.txt"
fileYTrain <- "./UCI HAR Dataset/train/Y_train.txt"

##  Create separate data frames for each file
subjectTrain <- read.table(fileSubjectTrain, col.names = "subjectID")

##  Header of columns should be assign from features data frame
xTrain <- read.table(fileXTrain, col.names = features$featureLabel)
yTrain <- read.table(fileYTrain, col.names = "activityID")


##  Merge all data frames into 1 data frames
trainFullDF<-cbind(subjectTrain, yTrain)
trainFullDF<-merge(activityLabels, trainFullDF)
trainFullDF<-cbind(trainFullDF, xTrain)
trainFullDF <- trainFullDF[order(trainFullDF$activityID, trainFullDF$subjectID),]

##  Extract columns that contains mean, std and keep 3 first column
trainMeansCol <- grep("mean", colnames(trainFullDF))
trainStdCol <- grep("std", colnames(trainFullDF))
baseCol <- c(1, 2, 3)
trainMeansStd <- sort(c(baseCol, trainMeansCol, trainStdCol))

##  Create new test data frame using only means and std columns
trainDF <- trainFullDF[,trainMeansStd]
row.names(trainDF)<-NULL

##  Merging testDF and trainDF together as requested
testTrainDF <- rbind(testDF, trainDF)

##  Save the data frame to a .txt file
write.table(testTrainDF, "./testTrain.txt")


##  Create new data set with averages of each variable for each activity and each subject
meansDF <- c()
for(sID in unique(testTrainDF$subjectID)){
        for(aID in unique(testTrainDF$activityID)){
                tempDF <-subset(testTrainDF, (testTrainDF$subjectID == sID & testTrainDF$activityID == aID))
                first3Col <- tempDF[1, 1:3]
                tempDF[1:3]<-list(NULL)
                tempColMeans <- as.list(colMeans(tempDF))
                tempColDF <- cbind(first3Col,tempColMeans)
                meansDF <- rbind(meansDF, tempColDF) 
        }
}

##  Save the data frame to a .txt file
write.table(meansDF, "./averages.txt")