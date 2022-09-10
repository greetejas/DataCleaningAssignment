# Raw data:

"Human Activity Recognition Using Smartphones Dataset
Version 1.0""

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws


The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws


# Analysis:
1. Set the directory of input files 

```{r}
setwd("directoryOfInputData") 
```
2. Ensure reshape2 and dplyr libraries are installed properly.
3. Run the script
```{r}
source("run_analysis.R") 
```

The script performs following actions:
* READ train set files: {X,Y,Subject}_train.txt
* READ test set files: {X,Y,Subject}_test.txt
* READ features.txt as they for the headers for x_t*.txt files
* Concatenate X files from test and train sets (using rbind) and rename the headers using the features 
* Select only mean and std dev (sd) based columns from the combined X dataset
* read activity labels to be used on y_t*.txt files
* Concatenate Y_t*.txt files using rbind function and merge with activity file to get labels using dplyr::inner_join function. 
* Select only the activity column as the final Y dataset
* Concatenate subject files using rbind function
* Finally, the merged output file is obtained by combining the concatenated dataframes of subject, y, and x in order using cbind function
* Update column names to suitable to tidy data
* Compute average each variable per activity per subject using dplyr::group_by and dplyr::summarise + across + mean functions
* Save the tidy dataset and the script

### Note:
Refer the comments in the script for the description of analysis steps for additional info.

# Outputs: 
### Tidy DataSet of Averages
A dataframe of 180 rows and 35 columns will be generated as output. The structure/explanations of these can be found in the "CodeBook.md". The tidy dataset represents the average values of each measurements computed for each activity in each subjects.