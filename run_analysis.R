#i.Read initial data
#i.1 Create subfolder "data"
if(!file.exists("./data")) {print("Create subfolder 'data'"); dir.create("./data")
} else {print("subfolder 'data' exists")}

#i.2 Download and unzip file
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/projectFile.zip", mode="wb")
unzip("./data/projectFile.zip", list=TRUE)[1]
unzip("./data/projectFile.zip", exdir="./data")

#i.3 From list of files we can see:
#1.values of Varible Activity consist of data from "€œY_train.txt"€ and "€œY_test.txt"€
#2.values of Varible Subject consist of data from "€œsubject_train.txt"€ and subject_test.txt"
#3.values of Varibles Features consist of data from "€œX_train.txt"€ and "€œX_test.txt"€
#4.names of Varibles Features come from "€œfeatures.txt"€
#5.levels of Varible Activity come from "€œactivity_labels.txt"€

#i.4 Files root path
rpathFiles<-file.path("./data" , "UCI HAR Dataset")

#i.5 Read the Activity files
dataActivityTest  <- read.table(file.path(rpathFiles, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(rpathFiles, "train", "Y_train.txt"),header = FALSE)

#i.6 Read the Subject files
dataSubjectTrain <- read.table(file.path(rpathFiles, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(rpathFiles, "test" , "subject_test.txt"),header = FALSE)

#i.7 Read Fearures files
dataFeaturesTest  <- read.table(file.path(rpathFiles, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(rpathFiles, "train", "X_train.txt"),header = FALSE)

#i.8 Read Fearures names
dataFeaturesNames  <- read.table(file.path(rpathFiles, "features.txt" ),header = FALSE)

#1. Merges the training and the test sets to create one data set

#1.1 Concatenate the data tables by rows
dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

#1.2 set names to variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
names(dataFeatures)<- dataFeaturesNames$V2

#1.3 Merge columns to get the data frame Data for all data
Data <- cbind(dataFeatures, dataSubject, dataActivity)

#2. Extracts only the measurements on the mean and standard deviation for each measurement

#2.1 Subset Name of Features by measurements on the mean and standard deviation
#i.e taken Names of Features with "€œmean()"€ or "€œstd()"€
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\()|std\\()", dataFeaturesNames$V2)]

#2.2 Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

#3. Uses descriptive activity names to name the activities in the data set

#3.1 Read descriptive activity names from "€œactivity_labels.txt"€
activityLabels <- read.table(file.path(rpathFiles, "activity_labels.txt"),header = FALSE)

#3.2 factorize variale activity in the data frame Data using descriptive activity names
Data$activity <- factor(Data$activity, levels=activityLabels$V1, labels=activityLabels$V2)

#4. Appropriately labels the data set with descriptive variable names

#In the former part, variables activity and subject and names of the activities have been 
#labelled using descriptive names. In this part, Names of Feteatures will labelled using 
#descriptive variable names.

# -prefix t is replaced by time
# -Acc is replaced by Accelerometer
# -Gyro is replaced by Gyroscope
# -prefix f is replaced by frequency
# -Mag is replaced by Magnitude
# -BodyBody is replaced by Body
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

#5. Ccreates a second, independent tidy data set with the average of each variable for each 
#activity and each subject

if(!is.element("plyr", installed.packages()[,1])){
    print("Installing packages 'plyr")
    install.packages("plyr")
}

library(plyr);
Data1<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data1[order(Data1$subject,Data1$activity),]
write.table(Data2, file = "dataTidy.txt",row.name=FALSE)
View(Data2)

#The tidy data is ready as "dataTidy.txt" in Work Directory.
#Initial data in path "./data/UCI HAR Dataset/".



