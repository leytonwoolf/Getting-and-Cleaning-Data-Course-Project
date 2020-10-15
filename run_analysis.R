library(dplyr)
library(reshape2)
##Check if folder to house data("Wearable Data") exists in current working directory and create if it does not exist
##Download file and unzip in folder "Wearable Data" into current working directory
if(!file.exists("./Wearable Data")){dir.create("./Wearable Data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Wearable Data/Dataset.zip")
unzip("./Wearable Data/Dataset.zip", exdir = "./Wearable Data")
##Read features.txt into R and create a list of column labels to used when creating data tables
features  <- read.table("./Wearable Data/UCI HAR Dataset/features.txt")
features <- features[, 2]
##Read 3 files into R for each folder : Train and Test
##Assign files to variables and give columns descriptive titles/names:
d.train <- read.table("./Wearable Data/UCI HAR Dataset/train/X_train.txt", col.names = as.list(features))
s.train <- read.table("./Wearable Data/UCI HAR Dataset/train/subject_train.txt")%>%rename(SUBJECT_ID = V1)
a.train <- read.table("./Wearable Data/UCI HAR Dataset/train/y_train.txt")%>%rename(ACTIVITY_CODE = V1)
d.test <-read.table("./Wearable Data/UCI HAR Dataset/test/X_test.txt", col.names = features)
s.test <-read.table("./Wearable Data/UCI HAR Dataset/test/subject_test.txt")%>%rename(SUBJECT_ID = V1)
a.test <-read.table("./Wearable Data/UCI HAR Dataset/test/y_test.txt")%>%rename(ACTIVITY_CODE = V1)
activity.sub <- function(x){
 a <- gsub(1, "WALKING", x)
 b <- gsub(2, "WALKING_UPSTAIRS", a)
 c <- gsub(3, "WALKING DOWNSTAIRS", b)
 d <- gsub(4, "SITTING", c)
 e <- gsub(5, "STANDING", d)
 f <- gsub(6, "LAYING", e)
}
a.train.CODE <- sapply(a.train, activity.sub)
a.test.CODE <- sapply(a.test, activity.sub)
##Combine Subject, Activity and Data Tables for both train and test data
test.comb <- cbind(s.test, a.test.CODE, data.test)
train.comb <- cbind(s.train, a.train.CODE, d.train) 
## Merge train and test data frames
data.merge <- rbind(train.comb, test.comb)
##Select columns with only mean or standard deviation variables
Wearables <- select(data.merge,ACTIVITY_CODE, SUBJECT_ID, contains("mean"), contains("std"))
##Create separate data frame from Wearables data frame composed of mean of all variables by activity code by subject
variable.list <- names(Wearables[, 3:88])
Wearables.1<- group_by(Wearables, ACTIVITY_CODE, SUBJECT_ID)%>% summarise_at(variable.list, mean)%>% melt(id = c("ACTIVITY_CODE", "SUBJECT_ID"), measure = variable.list)%>%rename(MEASUREMENT = variable, MEAN = value)


