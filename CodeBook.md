# CodeBook

This is a code book that describes the variables, the data, and any transformations or work performed to clean up the data.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article (http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 

## Data source
* Identifier: "Human Activity Recognition Using Smartphones Data Set" 
* The data was originally in the UCI repository: "http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones"
* The data for this project is available as a .zip in the following url: "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Data set information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Attribute Information
For each record it is provided:
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.

### The dataset includes the following files:
* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

### Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

### License:
Use of this dataset in publications must be acknowledged by referencing the following publication:
* Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


## Data cleaning process
The data was downloaded from the url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and extracted.
```{r, echo=FALSE}
source("downloadFromURL.R")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDir <- "./data" # unzip EZ DABIL HAU  ../data denean :_!
fileNameZIP <- "HARdata.zip"
filePathZIP <- paste(dataDir,fileNameZIP,sep="/")
downloadFromURL(fileUrl,workdirPath=dataDir,fileName=fileNameZIP)
unzip(zipfile=filePathZIP, exdir=dataDir)
```
Next, it was cleaned according to the following steps:
 1. Merge the training and the test sets to create one data set.
 2. Extract only the measurements on the mean and standard deviation for each measurement. 
 3. Use descriptive activity names to name the activities in the data set
 4. Appropriately label the data set with descriptive variable names. 
 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

The entire getting and cleaning data process was carried out in R, by the means of the script "src/run_analysis.R". The version specifications are as follows:
```{r} 
> version
platform       x86_64-apple-darwin10.8.0   
svn rev        66115                       
version.string R version 3.1.1 (2014-07-10)
```

### Information about the summary choices made
The script "src/run_analysis.R" in charge to carry out the cleaning proces makes a directory named "data" within the directory in which the script is run. The data-set is downloaded and extracted in that directory. Besides, it is processed, and the resulting tidy data from the 4th and 5th steps are denoted "data/outFile_Tidy_1.csv", "data/outFile_Tidy_2.csv" respectively.

## Code book
Information about the variables (including units!) in the data set not contained in the tidy data


