# Edwin Medrano-Abzun
# PROJECT - COURSERA.  
# Check if required packages are installed and load them

#CHECK IF PACKAGES ARE INSTALLED FOR THIS SCRIPT.
#if (!require("data.table")) {
 # install.packages("data.table")
#}
#if (!require("reshape2")) {
 # install.packages("reshape2")
#}
#  ^^^ UNCOMMENT THIS SECTION ABOVE IF YOU'RE TRYING TO RUN IN ON YOUR SYSTEM ^^^ 

library(data.table)
library(reshape2)

# Define the paths
downloaded_zip_path <- "C:/Users/Edwin/Downloads/getdata_projectfiles_UCI HAR Dataset.zip"
extracted_data_path <- "C:/Users/Edwin/Downloads/getdata_projectfiles_UCI HAR Dataset"
working_directory <- "C:/Users/Edwin/Documents"

# Set the working directory
setwd(working_directory)

# Unzip the dataset if it doesn't already exist
#if (!file.exists(extracted_data_path)) {
#  unzip(downloaded_zip_path, exdir = extracted_data_path)
#} # ^^ for whatever reason I thought I need it to extract. but fairly useless now

# Load activity labels and features paths 
activity_labels_path <- file.path(extracted_data_path, "UCI HAR Dataset", "activity_labels.txt")
features_path <- file.path(extracted_data_path, "UCI HAR Dataset", "features.txt")


# Selecting the mean and std features 
mean_std_features <- grepl("mean|std", features$featureNames)
measurements <- features$featureNames[mean_std_features]

# Load and process training data paths
train_data_path <- file.path(extracted_data_path, "UCI HAR Dataset", "train", "X_train.txt")
train_activities_path <- file.path(extracted_data_path, "UCI HAR Dataset", "train", "Y_train.txt")
train_subjects_path <- file.path(extracted_data_path, "UCI HAR Dataset", "train", "subject_train.txt")


# Load and process test data paths
test_data_path <- file.path(extracted_data_path, "UCI HAR Dataset", "test", "X_test.txt")
test_activities_path <- file.path(extracted_data_path, "UCI HAR Dataset", "test", "Y_test.txt")
test_subjects_path <- file.path(extracted_data_path, "UCI HAR Dataset", "test", "subject_test.txt")

# Combine training and test data
combined <- rbind(train, test)

# Using descriptive activity names
combined$Activity <- factor(combined$Activity, levels = activityLabels$classLabels, labels = activityLabels$activityName)

# # Convert SubjectNum to a factor to treat it as categorical data for analysis
combined$SubjectNum <- as.factor(combined$SubjectNum)

# Melt and casting data to create a tidy dataset with the average of each variable for each activity and subject
combinedMelt <- melt(combined, id.vars = c("SubjectNum", "Activity"))
tidyData <- dcast(combinedMelt, SubjectNum + Activity ~ variable, mean) # keeping SubjectNum & Activity as variable names for columns.

# Write the tidy dataset to a text file in the working directory
write.table(tidyData, file = "tidyData.txt", row.names = FALSE, quote = FALSE)