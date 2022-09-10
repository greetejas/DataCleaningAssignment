### Set working Directory
setwd("C:/Users/SW283QC/OneDrive - EY/Docs/Course Manuals/R_programming/DataCleaningAssignment/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

### load required libraries
library(dplyr)
library(reshape2)

### READ train set files
x_train <- read.table(file="./train/X_train.txt", header = FALSE, as.is = TRUE)

y_train <- read.table(file="./train/y_train.txt", header = FALSE, as.is = TRUE)

subject_train <- read.table(file = "./train/subject_train.txt", header = FALSE, as.is = TRUE)


### READ test set files
x_test <- read.table(file="./test/X_test.txt", header = FALSE, as.is = TRUE)

y_test <- read.table(file="./test/y_test.txt", header = FALSE, as.is = TRUE)

subject_test <- read.table(file = "./test/subject_test.txt", header = FALSE, as.is = TRUE)

### features => headers for x_t*.txt files
features <- read.table("features.txt")

### concatenate X files from test and train sets
x_df <- rbind(x_test, x_train)

### Add names to the merged X data from features
names(x_df) <- features[[2]]

### select only mean and std dev (sd) based columns from x dataset
x_mean_df <- x_df %>% select(all_of(contains("mean()")), all_of(contains("sd()")))

### read activity labels for y_t*.txt files
activity_labels <- read.table("activity_labels.txt", as.is = TRUE, header = FALSE)

### concatenate Y_t*.txt files
y_df <- rbind(y_test, y_train)

### include activity labels for y
y_df <- y_df %>% inner_join(activity_labels) %>% select(V2) %>% rename(activity=V2)

### concatenate subject files
subject_df <- rbind(subject_test, subject_train)
names(subject_df) <- "SubjectID"

### Remove unwanted data objects
rm(features, subject_test, subject_train, x_test, x_train, activity_labels, y_test, y_train)

### Final merged output file
combined_dataSet <- cbind(subject_df, y_df, x_mean_df)

### Give suitable/descriptive columns to the merged data
names(combined_dataSet) <- gsub("^t", "Time", names(combined_dataSet))
names(combined_dataSet) <- gsub("^f", "Freq", names(combined_dataSet))

names(combined_dataSet) <- gsub("Body", "_Body_", names(combined_dataSet))
names(combined_dataSet) <- gsub("Gravity", "_Gravity_", names(combined_dataSet))

names(combined_dataSet) <- gsub("Acc", "_Accelerometer_", names(combined_dataSet))
names(combined_dataSet) <- gsub("Gyro", "_Gyroscope_", names(combined_dataSet))

names(combined_dataSet) <- gsub("-", "_", names(combined_dataSet))
names(combined_dataSet) <- gsub("\\(|\\)", "", names(combined_dataSet))
names(combined_dataSet) <- gsub("_+", "_", names(combined_dataSet))

# names(combined_dataSet) <- gsub("", "", names(combined_dataSet))

### Save final merged/concatenated file
write.table(combined_dataSet, file = "combinedDataset.tsv", sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)

### Compute average each variable per activity per subject
# melted_df <- melt(data=combined_dataSet, id.vars = c("SubjectID", "activity"))
# 
# avg_df <- melted_df %>% group_by(SubjectID, activity, variable) %>% summarise(Average=mean(value, na.rm=TRUE))
mean_df <- combined_dataSet %>% group_by(SubjectID, activity) %>% summarise(across(everything(), mean, na.rm=TRUE))

#### Save final output
write.table(mean_df, file = "tidy_Dataset_of_averages.tsv", sep = "\t", row.names = FALSE, col.names = TRUE, quote = FALSE)

 # summary(mean_df)
