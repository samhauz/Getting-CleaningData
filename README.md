Getting-CleaningData
====================
This project is one of the mandatory requirements to complete the Data Science specialization from Johns Hopkins University through www.coursera.com. 

This is to:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive activity names.
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The code run_Analysis.R assumed that the working dorectory is located under /UCI HAR Dataset. 

Cleaned Data

The resulting clean dataset is in this repository at: data/cleaned.txt. It contains one row for each subject/activity pair and columns for subject, activity, and each feature that was a mean or standard deviation from the original dataset.
