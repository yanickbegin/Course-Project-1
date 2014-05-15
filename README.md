##Course-Project-1
================

##Getting and Cleaning data

###Introduction

The purpose of this project is to deliver a tidy data set based on data collected from the accelerometers from the Samsung Galaxy S smartphone.

# Step 1 -  Constructing initial data frames
The data has been subdivised into 2 main sets of data:  test and train.
Activity and subject labels are given in separate files with numerical IDs.  It is necessary to merge these data as to get complete data set with appropriate label.  It is also necessary to clean and rename some header as the initial names given are incorrect.

# Step 2 -  Extracting data about means and standard deviation
As requested, we need to keep only data about mean and standard deviation.  This can be done by using the function 'grep' that looks into the column headers to find matching strings 'mean' and 'std and return column index.  Then we simply keep these columns in a new data frame.

Step 1 and step 2 are repeated for both test and train data.  We end up with 2 data frame.

# Step 3 -  Merging test and train data frames
Now that we have a test and train data frame of means and standard deviations, we need to merge these 2 data frames to get only one.

# Step 4 -  Create a .txt file based on final data frame
testTrain.txt file is created based on data frame we got at step 3.

# Step 5 -  Creates a second, independent tidy data set with the average of each variable for each activity and each subject
For this step, we need to averages all data columns of data frame we got at step 3.  To do this, we use 2 for loops that get across all combinations of subject ID and activity ID and calculate the averages with function colMeans.  We need to re-construct row by row a new data frame containing all variables averages for each subject ID and activity ID combinations.

# Step 6 - Create a .txt file based on final data frame
averages.txt file is created based on data frame we got at step 5
