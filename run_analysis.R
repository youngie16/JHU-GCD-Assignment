
# Peer-graded Assignment: Getting and Cleaning Data Course Project : Lynda Young


#===================================================================================================
# As per the assignment step 1 is to merge test and train
# there are a number of sub-steps before this can be done labelled a., b., c. etc

#Step 1a: Working Directory and Directory structure 

setwd("C:/Users/Lynda Young/Documents/Coursera/Getting & Cleaning Data/Assignment data")



#===================================================================================================
# Step 1b: Obtain the data, unzip into working directory and read in the test and train observations
# download bit commented out as assignment assumes data is in working directory

library(downloader)
library(data.table)
library(dplyr)

#fileUrl <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download.file(fileUrl,destfile = "Dataset.zip",mode = "wb")
#unzip("Dataset.zip",exdir = "./Assignment data")

train <- fread("./UCI HAR Dataset/train/X_train.txt")
test <- fread("./UCI HAR Dataset/test/X_test.txt")

# data appears to be numeric between -1 and 1
#7532 obs in train + 2947 in test =   10,299 = 30 participants doing 6 activities
# there must be a differing number of observations per subject for each activity as 
# 10,299 is NOT divisible by 180
# 561-features vectors with time and frequency domain variables. 

#===================================================================================================
# 1c: assign variable names for train and test from the feature.txt data file
# (doing this before combining the subject data with the observations because otherwise seemed to have a problem with 
# the variable name of the subject)

var_names <- fread("./Assignment data/UCI HAR Dataset/features.txt")
names(train) <- var_names$V2
names(test) <-  var_names$V2

# there are duplicate column names which causes problems later on with column operations select and rename
# so identify multiple column names using code below and have a look at them

dups <- which(duplicated(var_names$V2))
var_names$V2[dups]

# can be seen that none of them are mean or sd of a variable and so will not be needed for our final data set
# so could remove these columns now so that later column operations will work - but then found the make.unique 
# routine which appends a sequence number to the duplicate columns so they become unique

names(train) <- make.unique(names(train))
names(test) <- make.unique(names(test))

#===================================================================================================
# 1d: Read in the subject data and the Activity data and add to the original train and test  observations 
# with meaningful names of Subject and Activity respectively
# (doing this before merging with activity labels as doing the merge re-orders the data based on activity number 
# and then the subject data wont align with the observations)

train_subject <- fread("./Assignment data/UCI HAR Dataset/train/subject_train.txt")
train_activity <- fread("./Assignment data/UCI HAR Dataset/train/y_train.txt")
train_subject <- rename(train_subject, Subject = V1)
train_activity <- rename(train_activity, Activity = V1)
train <- cbind(train_subject,train_activity,train)

test_subject <- fread("./Assignment data/UCI HAR Dataset/test/subject_test.txt")
test_activity <- fread("./Assignment data/UCI HAR Dataset/test/y_test.txt")
test_subject <- rename(test_subject, Subject = V1)
test_activity <- rename(test_activity, Activity = V1)
test <- cbind(test_subject,test_activity,test)

#===================================================================================================
# 1e: Combine train and test  and rename V1 and V2

combi.data <- rbind(train,test)

#===================================================================================================
# 2. Extract only mean and stdev for each measurement plus Subject (V1) & Activity (V2)
# Note: not sure about those variable names that are mean Frequency - however have erred on the safe side
# and included as can more easily exclude/ignore later rather than find out they were needed and not have them 

mean_stdev.data <- select(combi.data,contains("mean"),contains("std"),Subject,Activity)

#===================================================================================================
# 3. Uses descriptive activity names 
# Convert activity to a meaningful value and remove uneccessary data
# Ok to merge and reorder data because subject and activity have already been assigned to the observations

activity_labels <- fread("./Assignment data/UCI HAR Dataset/activity_labels.txt")
mean_stdev.data <- merge(mean_stdev.data, activity_labels, by.x = "Activity", by.y = "V1", all.x=TRUE)
mean_stdev.data <- mean_stdev.data %>%
              rename(Activity_label = V2) %>%
              select(-Activity) 

rm(activity_labels,combi.data,test,test_activity,test_subject,train,train_activity,train_subject,var_names,dups)

# better names needed

#3a. Introduce the word axis following X, Y and Z 


names(mean_stdev.data) <-gsub("-X","Xaxis",names(mean_stdev.data))
names(mean_stdev.data) <-gsub("-Y","Yaxis",names(mean_stdev.data))
names(mean_stdev.data) <-gsub("-Z","Zaxis",names(mean_stdev.data))
names(mean_stdev.data) <-gsub("\\()","",names(mean_stdev.data))
names(mean_stdev.data) <-gsub("^t","Time",names(mean_stdev.data))
names(mean_stdev.data) <-gsub("^f","Freq",names(mean_stdev.data))
names(mean_stdev.data) <-gsub("std","Stdev",names(mean_stdev.data))
#===================================================================================================
# 4: Create a second, independent tidy data set with the average of each variable for each activity and each subject.

summarised.data <- mean_stdev.data %>%
  group_by(Subject,Activity_label) %>%
  summarise_all(mean)

# check: now have 180 obs which would expect if 30 subjects with 6 activities each
# note that Subject and Activity Label are the first 2 columns in the summarised data and were the 
# last 2 in the non-summarised mean_stdev data

# names should be changed to reflect that they are now Averages 
a <- names(mean_stdev.data)[1:86] 
b <- paste("Average",a,sep = "-") 
c <- c("Subject","Activity-label")
summarised_names <- c(c,b)

names(summarised.data) <- summarised_names 

# Variable names could be re-ordered to be more sensible but this is a large task for 88 variables
# tried sorting but even alpha was not much better


rm(a,b,c,summarised_names)

#===================================================================================================
# Output summarised data 

write.table(summarised.data,row.names = FALSE,file = "Human Activity Recognition Using Smartphones - summarised assignment data 09Dec2016.csv")


temp <- fread('Human Activity Recognition Using Smartphones - summarised assignment data 09Dec2016.csv')

