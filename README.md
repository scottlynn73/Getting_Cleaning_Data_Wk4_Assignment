# Getting_Cleaning_Data_Wk4_Assignment
Repository for the Getting and Cleaning Data class project at the end of Week 4

This script is designed to provide a tidy data set as required in the assignment at the end of Week 4. The main script is named run_analysis.R and performs the following steps

1) Read in all required text files i.e. activity_labels.txt, features.txt, X_test.txt, Y_test.txt, X_train.txt, and Y_train.txt

2) Use the features.txt file as a vector of column names to use on the columns in both the X_test.txt and X_train.txt data.

3) Using the cbind command, combine the datasets so that the test and training data both have the subjects and activity codes as columns

4) Merge the test and training datasets using rbind

5) Extract the columns in the dataset that have "mean" or "std" in the name, using the grep command

6) Make a new data frame that has only the subject, activity, and mean/std of each variable

7) Add the descriptive activity name to the data frame using the merge by activity_code

8) Melt the dataset by the descriptive activity name

9) Take the mean value of all included features ordered by the activity and subject. 

10) Write a tidy data table as a text file- tidy_data.txt
