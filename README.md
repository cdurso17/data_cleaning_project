## data_cleaning_project
This is my repository for the deliverables for the project in the "Getting and Cleaning Data" course from Coursera. The script overview and code book follow.

### Script Overview

The data used in this script are from the UCI HAR Dataset which records sensor readings for 30 subjects each performing six activities. Each subject may perform an activity multiple times.

The purpose of this R script is to first assemble a data.frame in which the cases are observations of a subject carrying out an activity and the variables are the mean and standard deviations of the readings from each sensor during that case.

From this data frame, a summary data.frame is calculated with the same cases

The HAR data are divided into training and test data, which are to be merged for the data.frames described.

The UCI HAR Dataset includes a folder of training data, train, and a folder of test data, test. The training data folder contains a file X\_train.txt with summaries of the measurements in columns, with each column giving summarized values for each of the subject/activity cases. The file subject\_train.txt gives the subject for each row of  X\_train.txt. The file  Y\_train.txt gives the code for the activity for each row of X\_train.txt. The test data folder has the corresponding data files, X\_test.txt, subject\_test.txt, and Y\_test.txt.

In addition, the UCI HAR Dataset has a file of the names of the measurement summaries, features.txt, and a key to the name of the activity associated with each activity code, activity\_labels.txt.

The script reads activity\_labels.txt into a  data.frame, activity\_key.

The feature names are read into feature\_id, and the indices corresponding to mean or standard deviation summaries are extracted into keep\_col. The variable feature\_names stores the names of the features corresponding to mean or standard deviation summaries.

Then the test data measurements are loaded into the data.frame dat\_test and cleaned to contain just the mean and standard deviation summaries. The subject labels and activity codes for each row are attached as columns.

The same is done for the training data measurements in dat\_train.

These data.frames are stacked in dat using rbind. The activity codes are converted to the corresponding names using the information in activity\_labels.txt. The column names are assigned using feature\_names, reformatted for compactness.

A summary table, summary.data, is constructed giving the mean of each feature over the iterations of each subject-activity pair. 

During execution, unneeded structures are removed. At termination, the effect is to create a single new variable, summary.data, in the workspace. 

## Code Book
### Overview
The Samsung data set reports values from two sensors,  an accelerometer and a gyroscope, on the cellphones carried by the subjects during the activities. The outputs from these devices partitioned into a body component and a gravity component, analyzedtime to give derived values with respect to time. The Fast Fourier transforms of the signals were analyzed to give derived values with respect to frequency. Where applicable, X-, Y-, and Z- components are calculated.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag


Features are normalized and bounded within [-1,1]

###Variables in summary.dat 

* subject: a factor number identifying the subject, 1:30
* activity: a factor indentifying the activity, "LAYING", "SITTING", "STANDING", "WALKING", "WALKING\_DOWNSTAIRS", "WALKING\_UPSTAIRS" 
* remaining features are means of the indicated measurement for the subject and activity. 

For example, in the first row, the value in column tBodyAcc\_mean\_Z gives the mean of the mean time measurement of body acceleration in the z-direction for subject 1 in all repetitions of the activity "LAYING".

In the eighth row, in column tBodyAcc\_std\_Y the mean value of the standard deviation of body acceleration in the y-direction is given for all repetitions of subject 2 carrying out "SITTING".

The column name begins with "t" to indicate a time measurement or "f" to indicate a frequency measurement. This is followed by "Body" or "Gravity", then "Acc" or "Gyro" for the accelerometer or gyroscope respectively. The "\_mean\_" indicates a mean taken, while "\_std\_" indicates a standard deviation. Where applicable, a direction, "\_X", "\_Y", or "\_Z" follows.

  




