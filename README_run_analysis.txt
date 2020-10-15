The run_analysis.R script was created to tidy the data set: "Human Activity Recognition Using Smartphones Dataset"(heneforth
referred to as the HAR data set).

The HAR data set can be found @ https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Please refer to the READ ME and associated documents within this file for a description of the dataset.  NOTE:  This script
does not over-ride any features originally found in the HAR data set.

Purpose:
1. Extract and merge the various files in which data is stored in the HAR data set.  This includes:
	a.) Giving variables descriptive names
	b.) Giving numeric variables descriptive values.  
 **Effectively, creating a "near" tidy data-set of raw values ready to be split into useable, truly tidy data sets.**
2. Create a tidy data set where:
	a.) data is grouped by activity code and then by test subject id number
	b.) values for mean and standard deviation of measurements from the HAR data set are averaged 
	c.) data frame is reshaped into a new data frame where each row is composed of the activity, subject, measurement type, and average 
	    value of the recorded values of that measurement type

Output:
1.  Wearables.1:  As .csv file.  Tidy data set described in Goal #2

Process:
1.  Check to see if directory for file exists, if not, create one
2.  Download data and unzip in directory
3.  Import measurement, activity and subject data in R.  Concurrently, rename variables within all imported data frames with descriptive names
4.  Replace numeric activity codes with descriptive values
5.  Combine all data frames into a single data frame
6.  Select only mean and standard deviation variables of measurements from combined data frame
7.  Calculate average of selected measurements
8.  Tidy data set into averge of measurement per activity per subject



Script returns the Average of the Mean and Standard Deviations of the Following Measurements from the HAR data set:

tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Descriptive variables for the ACTIVITY ID column come from the HAR data set itself, particularly the activity_labels.txt and are
as follows:
1  WALKING
2  WALKING_UPSTAIRS
3  WALKING_DOWNSTAIRS
4  SITTING
5  STANDING
6  LAYING

Variables created/used in script:

fileUrl      : location of HAR dataset
features     : individual measurements within the HAR data set, originally a dataframe, converted to a list
d.train      : data frame of measurements from the training subset of the HAR data set
s.train      : data frame of subjects whose measurements were used for training 
a.train      : data frame of activities of the train data set measurements
d.test       : data frame of measurements from the test subset of the HAR data set
s.test       : data frame of subjects whose measurements were used for testing
a.test       : data frame of activities of the test data set measurements
activity.sub : is function designed to replace numeric activity codes with descriptive variable
a.train.CODE : activity data for train data set with numeric variable replaced with descriptive
a.test.CODE  : activity data for train data set with numeric variable replaced with descriptive
test.comb    : Combined activity, subject and measurement data frames for the test data set into a single data frame
train.comb   : Combined activity, subject and measurement data frames for the test data set into a single data frame
data.merge   : Combined train and test data frames into a single data frame
Wearables    : Combined data frame with only mean and standard deviation measurments selected
variable.list: List of measurement names in Wearables
Wearables.1  : Tidy data frame of average of each measurement in Wearables