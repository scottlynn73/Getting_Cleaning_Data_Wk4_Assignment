# load useful packages
library(reshape2)
library(plyr)
library(dplyr)
library(tidyr)

# read in the names of the activities and use these as column names
activities <- read.table("./activity_labels.txt", col.names = c("activity_code", "activity_name"))

# read in the features for use as column names in the dataframe
features <- read.table("./features.txt")
feature_names <- features[,2]

##### deal with the test data ######
# read in test data and use feature names for the column names
test_data <- read.table("./test/X_test.txt", col.names = feature_names)
# read the subject test data
test_subjects <- read.table("./test/subject_test.txt", col.names = "subject")
# read the test activity data
test_activity <- read.table("./test/y_test.txt", col.names= "activity_code")
# merge the test data
test_df <- cbind(test_subjects, test_activity, test_data)

##### deal with the training data ######
# read in training data and use feature names for the column names
train_data <- read.table("./train/X_train.txt", col.names = feature_names)
# read the subject training data
train_subjects <- read.table("./train/subject_train.txt", col.names = "subject")
# read the training activity data
train_activity <- read.table("./train/y_train.txt", col.names= "activity_code")
# merge the training data
train_df <- cbind(train_subjects, train_activity, train_data)

# merge the test and train data sets using rbind
test_train <- rbind(test_df, train_df)

##### Take the mean and std data out of the test_train dataset
##Keep only columns refering to mean() or std() values
mean_data <- grep("mean",names(test_train),ignore.case=TRUE)
mean_column <- names(test_train)[mean_data]
std_data <- grep("std",names(test_train),ignore.case=TRUE)
std_column <- names(test_train)[std_data]

# create new data frame with only the subject, activity and mean/std data columns
meanstddata <-test_train[,c("subject","activity_code",mean_column,std_column)]

# add the descriptive activity names to the dataset
descriptive <- merge(activities,meanstddata,by.x="activity_code",by.y="activity_code",all=TRUE) 

##Melt the dataset with the descriptive activity names
melted <- melt(descriptive,id=c("activity_code","activity_name","subject"))

##Cast the melted dataset by the average for each activity and each subject
mean_data <- dcast(melted,activity_code + activity_name + subject ~ variable,mean)

## Create a file with the new tidy dataset
write.table(mean_data,"./tidy_data.txt")

## Bring the tidy data set back into R for visual checking
tidy <- read.table("./tidy_data.txt")
