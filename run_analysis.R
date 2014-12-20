####################
## FILE NAME: run_analysis.R
## AUTHOR: apr
## LAST REVISION: 2014/12/20
## GOALS: 
## 0. Get and unzip the data
## 1. Merge the training and the test sets to create one data set.
## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropriately label the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##
## PRE-CONDITIONS:
##
## POST-CONDITIONS:
## - "data" directory is created, and both the original data and the tidy data are placed there
####################

####################
# BEGIN<SUB-ROUTINE><downloadFromURL>
# This sub-routine is designed to download data and it was already tested in other exercises
# Goal: download a file from a given url into a given directory and with a given name
# You can write the function in a separate file and next import the function with source
downloadFromURL <- function  (fileUrl="http://dir.csv", workdirPath=".", fileName="dataFile")
{
  # Checking for and creating directories
  if(!file.exists(workdirPath))
  {
    dir.create(workdirPath)
  }
  
  # Download the data file
  filePath=paste(workdirPath,fileName,sep="/")
  if(!file.exists(filePath))
  {
    download.file(fileUrl, destfile=filePath,method="curl")
    dateDownloaded <- date()
    print(paste("INFO: the data file downloaded on: ", dateDownloaded))
  }
  else{
    print("Saionara baby!")
  }
}
# END<SUB-ROUTINE><downloadFromURL>
# This is how you can import the function if you eventually decide to get it in a separate file called "downloadFromURL.R": 
# source("downloadFromURL.R")
####################

####################
# BEGIN<MAIN-ROUTINE>
# MAIN-ROUTINE: There we go with the Getting and Cleaning Data process:
# -----------------------------
# Step 0: Download and unzip the "Human Activity Recognition Using Smartphones Data Set" 
# -----------------------------
#
dataDir <- "./data" # HAU  ../data DENEAN unzip EZ DABIL:_!
#
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileNameZIP <- "UCI_HAR_Dataset.zip"
filePathZIP <- paste(dataDir,fileNameZIP,sep="/")

downloadFromURL(fileUrl,workdirPath=dataDir,fileName=fileNameZIP)
unzip(zipfile=filePathZIP, exdir=dataDir) 


# -----------------------------
# Step 1: Load subjects, features, and labels into R objects 
# -----------------------------
## Get the subjects
subject_test  <- read.table(paste(dataDir,"UCI HAR Dataset/test/subject_test.txt",sep="/"))
subject_train <- read.table(paste(dataDir,"UCI HAR Dataset/train/subject_train.txt",sep="/"))
## Get the features
x_test  <- read.table(paste(dataDir,"UCI\ HAR\ Dataset/test/X_test.txt",sep="/"))
x_train <- read.table(paste(dataDir,"UCI\ HAR\ Dataset/train/X_train.txt",sep="/"))
## Get the activities 
y_test  <- read.table(paste(dataDir,"UCI\ HAR\ Dataset/test/y_test.txt",sep="/"))
y_train <- read.table(paste(dataDir,"UCI\ HAR\ Dataset/train/y_train.txt",sep="/"))
## Get the labels for the activities
ylabels <- read.table(paste(dataDir,"UCI HAR Dataset/activity_labels.txt",sep="/")) # here the label is a factor of a number-code and activity-label
## Re-label the activities. Use descriptive activity names to name the activities in the data set
for (i in ylabels$V1) {
  y_test$V1[y_test$V1 == i]   <- as.character(ylabels$V2[i])
  y_train$V1[y_train$V1 == i] <- as.character(ylabels$V2[i])
}
# GOAL 3: Done!


# -----------------------------
# Step 2: Merge the training and the test sets to create one data set.
# -----------------------------
## Column-bind: subject, features and activity
x_y_test  <- cbind(subject_test, x_test, y_test) 
x_y_train <- cbind(subject_train, x_train, y_train) 

## Merge the training and the test sets to create one data set.  
data <- rbind(x_y_train,x_y_test) 
# GOAL 1: Done!


# -----------------------------
# Step 3: Appropriately label the data set with descriptive variable names. 
# -----------------------------
# Read the names of the features
features <- read.table(paste(dataDir,"UCI HAR Dataset/features.txt",sep="/")) # Honek bi atributu ditu posizioa eta izena
features <- features[2] # amaieran, frame motakoa da
names(features) <- c("featName")
# Add the names: subject, features, activity
names(data)  <- c("subject",as.character(features$featName),"activity") 
# GOAL 4: Done!

# Remove useless objects (otherwise, my old laptop may run out of memory:)
remove(x_y_train,x_y_test,x_train,x_test,y_train,y_test,ylabels,features,subject_test,subject_train)


# -----------------------------
# Step 4: Extract only the measurements on the mean and standard deviation for each measurement. 
# -----------------------------
## Select the features containing information about either "mean" or "std" or "subject" (first) or "activity" (last)
usefulFeatIdx <- unique(grep("mean|std|subject|activity", names(data), ignore.case = TRUE))
data  <- subset(data, select=usefulFeatIdx) 
# GOAL 2: Done!
## Write the tidy data into an output file
outFile1="outFile_Tidy_1.csv"
write.csv(data, file=paste(dataDir, outFile1 ,sep="/"), row.names=FALSE)
### Alternatively: outFile1="outFile_Tidy_1.txt"
### Alternatively: write.table(data, file=paste(dataDir, outFile1 ,sep="/"), sep=",", row.names=FALSE)


#-----------------------------
# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
#-----------------------------
AvVble_perSubject <- by(data, INDICES=list(SUBJECT=data$subject,ACTIVITY=data$activity), FUN=
     function(x){
       y <- subset(x, select=-c(subject,activity)) # Do not make the mean neither of the subject nor of the activity:!
       apply(y, 2, mean) # Remember: 1 indicates rows, 2 indicates columns, c(1, 2) indicates rows and columns.
     } 
   )
# GOAL 5: Done!
print("There you are the the average of each variable for each activity and each subject")
AvVble_perSubject
## Please upload the tidy data set created in step 5 of the instructions. 
## Please upload your data set as a txt file created with write.table() using row.name=FALSE
## Write the data into an output file
outFile2="outFile_Tidy_2.txt"
write.table(AvVble_perSubject, file=paste(dataDir, outFile2 ,sep="/"), sep="\n", row.names=FALSE, col.names=FALSE)
## Emaitza pantailatik inprimatzean zuzena dela ematen du, baina fitxategiak ez du itxura ona:-!
# END<MAIN-ROUTINE>
####################

