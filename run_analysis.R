#reading the features file
setwd("UCI HAR Dataset")
feat <- read.table("features.txt", fill = TRUE, sep = " ", strip.white = TRUE, skipNul = TRUE)
#readind label names into dataset
labels <- read.table("activity_labels.txt", sep = "\n")
#splitting one column, which contains index and name into two,
#first containing index, and second - name of a label
labels <- data.frame(do.call('rbind', strsplit(as.character(labels$V1),' ',fixed=TRUE)))



#preparing test
#reading file with test observations
test <- read.table("test/X_test.txt", fill = TRUE, strip.white = TRUE, skipNul = TRUE)
#assigning names for the test variables from the features
names(test) <- feat[,2]
#reading activity marks for the test
t_y <- read.table("test/Y_test.txt", fill = TRUE, sep = " ", strip.white = TRUE, skipNul = TRUE)
#reading subject for the test
st <- read.table("test/subject_test.txt", fill = TRUE, strip.white = TRUE, skipNul = TRUE)

#combining together activity marks, subjects and test observations
test_all <- cbind(t_y, st, test)


#preparing train
#reading file with train observations
train <- read.table("train/X_train.txt", fill = TRUE, strip.white = TRUE, skipNul = TRUE)
#assigning names for the train variables from the features
names(train) <- feat[,2]
#reading activity marks for the train
tr_y <- read.table("train/Y_train.txt", fill = TRUE, strip.white = TRUE, skipNul = TRUE)
#reading subject for the train
str <- read.table("train/subject_train.txt", fill = TRUE, strip.white = TRUE, skipNul = TRUE)

#combining together activity marks, subjects and train observations
train_all <- cbind(tr_y, str, train)

#combining test and train datasets
all <- rbind(train_all, test_all)
#giving names for the columns with subjects and activity labels
names(all)[1] <- "activity"
names(all)[2] <- "subject"

#creating vector with all names of variables, and vector "means" to store only
#names of mean and standard deviation variables
c <- names(all)
means <- c("activity", "subject")

#defining names of mean and std variables using regular expressions
#assuming, that we have to find variables containing function names ("mean()"
#and "std()")
for (t in 1:length(c)) if (length(grep("mean()", c[t], ignore.case=FALSE, fixed=TRUE)) > 0 | length(grep("std()", c[t], ignore.case=FALSE, fixed=TRUE)) > 0) means <- c(means, c[t])
all1 <- all[,means]

#replacing activity marks with descriptive label names
for (i in 1:length(all1[,1])) all1[i,1] = as.character(labels[all1[i,1],2])

#aggregating data set
all_arg = aggregate(all1[,-1:-2], list(Activity = all1$activity, Subject = all1$subject), mean)
