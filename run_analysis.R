#################################################################
# Assemble a data.frame of the feature measurements for the test
# and training data, labeled by subject and activity.
# Create a second data.frame with the average of each variable
# for each subject and activity.
# When the script is run, the following final result will be that
# the working directory will have one new item, summary.txt,
# containing the summary table of the means of each variable 
# for activity for each subject.  
#
# The Samsung data is assumed to be in the working directory.
# For brevity, checks on the existence of each file are omitted.
################################################################# 
require(plyr)

## Load the key associating activity numbers and descriptions.
activity_key<-read.table("UCI HAR Dataset/activity_labels.txt")

## Load the feature descriptions. 
features_id<-read.table("UCI HAR Dataset/features.txt")

##Identify the locations of the mean() and the std() features
keep_col<-grep("mean[(]|std[(]",features_id[,2])

## Build and clean the feature names to work better in a data frame:
## Remove "-" and "()" from the feature names.
feature_names<-as.character(features_id[keep_col,2])
feature_names<-gsub("-","_",feature_names)
feature_names<-gsub("[(,)]","",feature_names)


## Collect the test data.
feature_data<-read.table("UCI HAR Dataset/test/X_test.txt")
subject_label<-read.table("UCI HAR Dataset/test/subject_test.txt")
activity_code<-read.table("UCI HAR Dataset/test/Y_test.txt")
dat_test<-data.frame(feature_data[,keep_col])
dat_test<-cbind(subject_label,activity_code,dat_test)

## Collect the training data (same code, but one repetition
## isn't worth writing a function)

feature_data<-read.table("UCI HAR Dataset/train/X_train.txt")
subject_label<-read.table("UCI HAR Dataset/train/subject_train.txt")
activity_code<-read.table("UCI HAR Dataset/train/Y_train.txt")
dat_train<-data.frame(feature_data[,keep_col])
dat_train<-cbind(subject_label,activity_code,dat_train)

rm("feature_data","subject_label","activity_code") # Remove obsolete data.


## Stack the training and the test set, label the columns, and 
## cast subject and activity as factors 
dat<-rbind(dat_test,dat_train)
rm("dat_test","dat_train") # Remove obsolete data.
names(dat)<-c("subject","activity",feature_names)
dat<-data.frame(dat)
dat$subject<-factor(dat$subject)
dat$activity<-activity_key[dat$activity,2]

## Create a summary table with the mean for each variable by subject 
## and activity.
summary.data <- ddply(dat, .(subject, activity), colwise(mean))
write.table(summary.data,file="summary.txt",row.names=FALSE)
	# This table may be read back into R with
	# read.table("summary.txt",header=TRUE)
rm("activity_key","dat","feature_names","features_id","keep_col")









