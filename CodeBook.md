#H1 Tidy data set construction

I extracted the X_(test|training).txt, subject_(test|training).txt, and y_(test|training).txt files and bound the columns together using cbind. Then I used rbind to join the test and training data together and added column headers from features.txt. I converted the activity indices to names by looking them up in activity_labels.txt. Finally I selected just the columns that ended with "mean()" or "std()".

#H1 Analysis

I used R's ave function to calculate an average of each data column by the Subject and Activity columns. Then I used unique to shorten the data frame.

#H1 Variables

The variables in the final data set, summary.csv, are:

1. Subject - a numeric code identifying the subject
2. Activity - one of 6 activities: LYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS
3. The mean of each activity studied for each subject and each activity.
..* mean of tBodyAccMag-mean()
..* mean of tBodyAccMag-std()
..* mean of tGravityAccMag-mean()
..* mean of tGravityAccMag-std()
..* mean of tBodyAccJerkMag-mean()
..* mean of tBodyAccJerkMag-std()
..* mean of tBodyGyroMag-mean()
..* mean of tBodyGyroMag-std()
..* mean of tBodyGyroJerkMag-mean()
..* mean of tBodyGyroJerkMag-std()
..* mean of fBodyAccMag-mean()
..* mean of fBodyAccMag-std()
..* mean of fBodyBodyAccJerkMag-mean()
..* mean of fBodyBodyAccJerkMag-std()
..* mean of fBodyBodyGyroMag-mean()
..* mean of fBodyBodyGyroMag-std()
..* mean of fBodyBodyGyroJerkMag-mean()
..* mean of fBodyBodyGyroJerkMag-std()
