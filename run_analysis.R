#
# Johns Hopkins Bloomberg School of Public Health
# Coursera, Getting and Cleaning Data
# Course Project
#

# Set folders, filenames and file URL
datafolder <- "./data"
if(!file.exists(datafolder)){
    dir.create(datafolder)
}

datasetfolder <- paste(datafolder, "/", "UCI HAR Dataset", "/", sep="")

zippedFileName <- paste(datafolder, "/", "getdata_projectfiles_UCI_HAR_Dataset.zip", sep="")
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Download the data and unzip
download.file(fileURL, destfile=zippedFileName, method="curl")
unzip(zippedFileName, exdir=datafolder)
dateDownloaded <- date()

# Load all data available
xtrain <- read.table(paste(datasetfolder, "train/X_train.txt", sep=""))
xtest <- read.table(paste(datasetfolder, "test/X_test.txt", sep=""))
ytrain <- read.table(paste(datasetfolder, "train/y_train.txt", sep=""))
ytest <- read.table(paste(datasetfolder, "test/y_test.txt", sep=""))
subjtrain <- read.table(paste(datasetfolder, "train/subject_train.txt", sep=""))
subjtest <- read.table(paste(datasetfolder, "test/subject_test.txt", sep=""))

# Load annotations to use it in preparing tidy dataset
activityLabels <- read.table(paste(datasetfolder, "activity_labels.txt", sep=""))
variableLabels <- read.table(paste(datasetfolder, "features.txt", sep=""))
names(xtrain) <- variableLabels$V2
names(xtest) <- variableLabels$V2

dataset <- rbind(xtrain,xtest)
classes <- rbind(ytrain, ytest)
classes <- factor(classes$V1, labels=as.vector(activityLabels$V2))
subjects <- rbind(subjtrain,subjtest)

# Find out which are the features based on measurement means and standard deviations.
requiredLabelsLog <- (grepl(".*?mean\\(\\).*", variableLabels$V2) | grepl(".*?std\\(\\).*", variableLabels$V2))

requiredLabels <- as.vector(variableLabels$V2[requiredLabelsLog])

# Drop all the data except the required features
dataset <- dataset[, names(dataset) %in% requiredLabels]

# Check whether any NA values exist
colSums(is.na(dataset))

# Fix variable names
currNames <- names(dataset)
currNames <- gsub("-", ".", currNames)
currNames <- gsub("mean\\(\\)", "mean", currNames, perl=TRUE)
currNames <- gsub("std\\(\\)", "std", currNames, perl=TRUE)
names(dataset) <- currNames

# Add class labels and subject information to the data frame
dataset$class <- classes
dataset$subject <- subjects$V1

# Proceed with obtaining the average of each variable for each activity and each subject
tidyDataset <- aggregate(. ~ class + subject, data=dataset, mean)

# Write out the second, independent tidy data set with the average of each variable for each activity and each subject.
write.table(tidyDataset, file="tidyDataset.txt", sep="\t", quote=FALSE, row.names=FALSE)
