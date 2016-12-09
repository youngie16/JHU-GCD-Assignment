# JHU-GCD-Assignment
JHU Getting and Cleaning Data Assignment : youngie16

========================================================================================================================================
This Readme was created as part of the requirements of the assignment for week4 of the JHU online course "Getting and Cleaning Data"
=======================================================================================================================================


Experiment Data : Human Activity Recognition Using Smartphones 

Source of "raw" and "initial processed" data*: Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
                                              Smartlab - Non Linear Complex Systems Laboratory
                                              DITEN - Università degli Studi di Genova.
                                              Via Opera Pia 11A, I-16145, Genoa, Italy.
                                              activityrecognition@smartlab.ws
                                              www.smartlab.ws 


Name of final summarised data: 'Human Activity Recognition Using Smartphones - summarised assignment data 09Dec2016.csv'

========================================================================================================================================

ASSIGNMENT SPECIFICATION

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

========================================================================================================================================

Files included in this project (excluding the "raw"and "initial processed" data which are described in the codebook) are:

- 'README.md'

- 'Codebook JHU assignment.txt' - description of study design, original data provided and final summarised data including an overview of the manipulations on that data

-  'run_analysis.R' - R script used to process the data into tidy form as specified by the asignment

-  'Human Activity Recognition Using Smartphones - summarised assignment data 09Dec2016.csv' - final summarised data




< code to read in final data as follows:

library(data.table)

data <- fread('Human Activity Recognition Using Smartphones - summarised assignment data 09Dec2016.csv')


 
========================================================================================================================================
[*] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012 This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited. Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
