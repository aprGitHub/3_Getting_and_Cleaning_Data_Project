
Getting and Cleaning Data: Project
==================================

 The purpose of this project is to gain ability to collect, work with, and clean a data set. 
 The goal is to prepare tidy data that can be used for later analysis. 


## 1. Content of this directory
  1. "README.md": this file
  2. "data" directory contains:
	* The original data-set zipped ("HARdata.zip") and also unzipped ("UCI HAR Dataset")
	* Tidy data: "outFile_Tidy1.csv" and "outFile_Tidy2.txt" obtained from the original one by means of the following R script: "src/run_analysis.R" (to be precise, from the 4th and 5th steps respectively).
  3. "CodeBook.md": a code book that describes the variables, the data, and any transformations or work performed to clean up the data  
  4. "run_analysis.R": is the main script used to get and clean the original data-set. 


## 2. Documentation of "run_analysis.R"
### 2.1 Goal
run_analysis.R is the script used to get and clean the data. It proceeds as follows: 
* 0. Downloads and unzips the data-set 
* 1. Merges the training and the test sets to create one data set.
* 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
* 3. Uses descriptive activity names to name the activities in the data set
* 4. Appropriately labels the data set with descriptive variable names. The resulting data-set is written in the file "data/outFile_Tidy_1.csv"
* 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. The result of this step is written in the file "data/outFile_Tidy_2.txt"

### 2.2 Post-conditions:
* The scripts makes use of a directory "./data", actually, the script itself creates this directory unless it did exist in advance.
* Both the original data and the tidy data are placed there.


## 3. Documentation of the corpus 
To find out a detailed documentation of the corpus turn to "CodeBook.md" within this project.
