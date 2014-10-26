getcleandatacoursera
====================

The analyses is performed as follows:
1) The datasets, containing names for the variables and descriptive activity names are made by reading features.txt and activity_labels.txt
Dataset which contains activity labels is divided into two colums, one containing activity index and second containing activity name.
2) Data from X_test.txt is read into a dataset using read.table with fill = TRUE, strip.white = TRUE, skipNul = TRUE
Activity marks and subjects are read into two other datasets using read.table with same parameters.
Then the names for the X_test dataset are assigned using the features dataset from the step 1)
3) Activity marks, subjects and X_test are combined into one dataset using cbind.
4) Creating train part of the final dataset following the same logic as with the test part.
Data from X_train.txt is read into a dataset using read.table with fill = TRUE, strip.white = TRUE, skipNul = TRUE
Activity marks and subjects are read into two other datasets using read.table with same parameters.
Then the names for the X_train dataset are assigned using the features dataset from the step 1)
5) Activity marks, subjects and X_train are combined into one dataset using cbind.
6) Test and train parts are combined using rbind
7) Assigning descriptive names for the colums, containing activity names and subject indexes.
8) In order to subset the dataset, leaving only mean and standard deviation observations, doing the following:
- creating vector with all variable names:
- creating new vector with only those variable names, who match search pattern "mean()" or "std()", using regular expressions
- subsetting dataset with vector from the previous step.
9) Replacing activity marks with descriptive label names by searching activity index in activity_labels dataset, defining descriptive name for that index and replacing index in test&train dataset by the descriptive name.
10) Aggregating dataset using aggregate() by activity and subject and using mean as aggregate function. 
