###This file describes the processing flow for the run_analysis.R code as part of the course project for the Getting and Cleaning Data course.

This code can be used to organize the raw data from the Samsung Galaxy S II UCI HAR dataset collected by the study Human Activity Recognition Using Smartphones Dataset, available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

----------//----------//----------//----------//----------//----------//----------//----------//

The entire code can be run by entering source(“run_analysis.R”) when both the run_analysis.R and the Samsung Galaxy S II UCI HAR dataset are present on the working directory.

###The code is divided in five parts:
1. Reads and merges all the train and the test datasets into a single data set.
2. Extracts the measurements on the mean and standard deviation for each measurement.
3. Assigns the descriptive activity names to the activities variable in the data set.
4. Labels the data set with descriptive variable names.
5. Create a tidy data set with the average of each variable for each activity and each subject.

----------//----------//----------//----------//----------//----------//----------//----------//

##Part 1)

The code takes the list of all the test and train files available on the Samsung Galaxy S II UCI HAR dataset. The information to open all the files is kept in the R variable “file_paths”. The files are then read and an extra table variable “sample” is introduced to track if the observation was from a testing or training sets. The file where the data was extracted is encoded in the numeric table variable name. This data is saved into the R variables “test_data” and “train_data”. These datasets are then merged into a single R variable “data”.

##Part 2)

The code follows by looping thought the R variable “data” and subsetting each numerically encoded table variable. The means and standard deviation of the rows of each subset is then calculated and merged into the R variable “newdata”. Because the data for the table variables “subjects”, “activity” and “sample” are made of single observations, these were added without any modification to the 
R variable “newdata”. 

##Part 3)

The “activity_labels.txt” file is read and for each value of the R variable “newdata” column 4 (table variable “activities”) corresponding to the numbers of the first column of the “activity_labels.txt” table, was replaced by the description from the second column of the “activity_labels.txt” table. 
The numerical code for the “sample” table variable was also replaced, where 1 corresponded to test and 2 corresponded to train.

##Part 4)

The names for each measured table variable were added to the R variable “newdata”. Care is taken to ensure that the order by which the files were read into R was kept, based on the numeric encoded name.

##Part 5)

Finally, two loops subset each individual subject data and then take the mean of the columns for each table variable split by the table variable activity. The resulting matrices are merged together, and the mean values for each subject is added to the “tidy” R variable.  As the metadata for the table variables names was lost and the order of the table variables changed during this process, the names were reapplied and the table variables reorganized into a new “data” R variable. The “tidydata.txt” file is them written to the working directory.

