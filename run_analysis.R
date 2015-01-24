# Switch between development/testing mode and production
rows_to_load = -1

# Parent folder of the data set
parent_folder <- "UCI HAR Dataset"

# Get a descriptive label for the activity from the y_test.txt and y_train.txt file values
get_activity_label <- function(x) {
  activity_labels[x,2] 
}

# Load the test or training data
load_subset <- function(subset, num = -1) {
  x_data <- read.table(paste(parent_folder, "/", subset, "/X_", subset, ".txt", sep = ""), nrows = num)
  subject_data <- read.table(paste(parent_folder, "/", subset, "/subject_", subset, ".txt", sep = ""), nrows = num)
  y_data <- read.table(paste(parent_folder, "/", subset, "/y_", subset, ".txt", sep = ""), nrows = num)
  cbind(subject_data, lapply(y_data, get_activity_label), x_data)
}

# The activity labels and features are common to both the training and test sets
activity_labels <- read.table(paste(parent_folder, "/activity_labels.txt", sep = ""))
features <- read.table(paste(parent_folder, "/features.txt", sep = ""))

# Load the training and test data and join into a single table
test <- load_subset("test", rows_to_load)
train <- load_subset("train", rows_to_load)
data <- rbind(test, train)

# Add the column names to training and test data
colnames(data) <- c("Subject", "Activity", as.character(features[,2]))

# Select only the subject column, activity column, and columns of
# means and standard deviations
data <- data[,c(1,2,grep("mean\\(\\)$|std\\(\\)$", colnames(data)))]

# Iterate over the data columns and calculate an average by subject and activity
summary <- data[,1:2]
for (i in 3:ncol(data)) {
  summary[,i] <- ave(data[,i], data[,1:2], FUN = mean)
}
summary <- unique(summary)
cnames <- colnames(data)
for (i in 3:length(cnames)) {
  cnames[i] <- paste("mean of", cnames[i])
}
colnames(summary) <- cnames

# Sort by subject and then by activity.
# Activity is sorted alphabetically, but it also seems to be in increasing
# order of strenuousness!
summary <- summary[order(summary$Subject, summary$Activity),]

write.table(data, file = "tidy_data.txt", row.names = FALSE, col.names = TRUE)
write.table(summary, file = "summary.txt", row.names = FALSE, col.names = TRUE)
