# Course Project

##Att! My file "run_analysis.R" for Windows only! If you have Mac system please use file "run_analysis_mac.R".  
##i.Read initial data
###i.1 Create subfolder "data"
###i.2 Download and unzip file
###i.3 From list of files we can see:
####1.values of Varible Activity consist of data from "Y_train.txt" and "Y_test.txt"
####2.values of Varible Subject consist of data from "subject_train.txt" and subject_test.txt"
####3.values of Varibles Features consist of data from "X_train.txt" and "X_test.txt"
####4.names of Varibles Features come from "features.txt"
####5.levels of Varible Activity come from "activity_labels.txt"
###i.4 Files root path
###i.5 Read the Activity files
###i.6 Read the Subject files
###i.7 Read Fearures files
###i.8 Read Fearures names

##1. Merges the training and the test sets to create one data set
###1.1 Concatenate the data tables by rows
###1.2 set names to variables
###1.3 Merge columns to get the data frame Data for all data

##2. Extracts only the measurements on the mean and standard deviation for each measurement
###2.1 Subset Name of Features by measurements on the mean and standard deviation
###i.e taken Names of Features with "mean()" or "std()"
###2.2 Subset the data frame Data by seleted names of Features

##3. Uses descriptive activity names to name the activities in the data set
###3.1 Read descriptive activity names from "activity_labels.txt"
###3.2 factorize variale activity in the data frame Data using descriptive activity names

##4. Appropriately labels the data set with descriptive variable names
###In the former part, variables activity and subject and names of the activities have been 
###labelled using descriptive names. In this part, Names of Feteatures will labelled using 
###descriptive variable names.
#### -prefix t is replaced by time
#### -Acc is replaced by Accelerometer
#### -Gyro is replaced by Gyroscope
#### -prefix f is replaced by frequency
#### -Mag is replaced by Magnitude
#### -BodyBody is replaced by Body

##5. Ccreates a second, independent tidy data set with the average of each variable for each 
##activity and each subject

##Results:
###The tidy data is ready as "dataTidy.txt" in Work Directory.
###Initial data in path "./data/UCI HAR Dataset/".
