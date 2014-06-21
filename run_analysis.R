# Working Directory set under "UCI HAR DataSet"

# 1. Merges the TRAINING and TEST data sets to create one DATA SET.

trainDat <- read.table("train/X_train.txt")
testDat <- read.table("test/X_test.txt")
ConTrainTest <- rbind(trainDat, testDat)

trainDat <- read.table("train/subject_train.txt")
testDat <- read.table("test/subject_test.txt")
ConTrainTest2 <- rbind(trainDat, testDat)

trainDat <- read.table("train/y_train.txt")
testDat <- read.table("test/y_test.txt")
ConTrainTest3 <- rbind(trainDat, testDat)

# 2. Extracts only the measurements on the MEAN and STANDARD DEVIATION for each measurement.

FEATURE <- read.table("features.txt")
GOOD_FEATURE <- grep("-mean\\(\\)|-std\\(\\)", FEATURE[, 2])
ConTrainTest <- ConTrainTest[, GOOD_FEATURE]
names(ConTrainTest) <- FEATURE[GOOD_FEATURE, 2]
names(ConTrainTest) <- gsub("\\(|\\)", "", names(ConTrainTest))
names(ConTrainTest) <- tolower(names(ConTrainTest)) 

# 3. Uses descriptive activity names to name the activities in the data set

ACTIVITIES <- read.table("activity_labels.txt")
ACTIVITIES[, 2] = gsub("_", "", tolower(as.character(ACTIVITIES[, 2])))
ConTrainTest3[,1] = ACTIVITIES[ConTrainTest3[,1], 2]
names(ConTrainTest3) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(ConTrainTest2) <- "subject"
CLEANED <- cbind(ConTrainTest2, ConTrainTest3, ConTrainTest)
write.table(CLEANED, "MERGED_CLEANED_DATA.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

UNIQUESub = unique(ConTrainTest2)[,1]
NUMSub = length(unique(ConTrainTest2)[,1])
NUMActivities = length(ACTIVITIES[,1])
NUMCols = dim(CLEANED)[2]
RESULT = CLEANED[1:(NUMSub*NUMActivities), ]


x = 1
for (ConTrainTest2 in 1:NUMSub) 
  {
  for (a in 1:NUMActivities) 
  {
    fRes[x, 1] = UNIQUESub[ConTrainTest2]
    fRes[x, 2] = ACTIVITIES[a, 2]
    tmp <- CLEANED[CLEANED$subject==ConTrainTest2 & CLEANED$ACTIVITIES==ACTIVITIES[a, 2], ]
    fRes[x, 3:numCols] <- colMeans(tmp[, 3:numCols])
    x = x+1
  }
}

write.table(fRes, "CleanedData.txt")

