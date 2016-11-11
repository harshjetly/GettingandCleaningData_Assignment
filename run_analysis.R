library(dplyr)
run_analysis <- function(folderName){
      
      #Read feature List 
      featureList <- read.table(paste("./", folderName , "/features.txt", sep = ""), header = FALSE)
      featureList_tbl <- tbl_df(featureList)
      
      #Filter only the std() & mean() features from the list along with their indices
      featureList_std_mean_tbl <- filter(featureList_tbl, grepl('-std()|-mean()', V2) & !grepl("meanFreq()", V2))
      write.csv(featureList_std_mean_tbl, file = "./UCI_HAR/filteredVariableNames.csv")
      
      #Read Activity Labels 

      activityLabel <- read.table(paste("./", folderName,  "/activity_labels.txt", sep=""), header = FALSE)
      activityLabel_tbl <- tbl_df(activityLabel)

      # Read Test Data & Training Data 
      ## Read Variables from X_test.txt
      
      testData <- read.table(paste("./", folderName , "/test/X_test.txt", sep = ""), header = FALSE)
      testData_tbl <- tbl_df(testData)
      
      ## Read Variables form X_train.txt
      
      trainData <- read.table(paste("./", folderName , "/train/X_train.txt", sep = ""), header = FALSE)
      trainData_tbl <- tbl_df(trainData)
      
      #Filtered Test & Train Data containing std() & mean values()
      testData_std_mean_tbl <- testData_tbl[featureList_std_mean_tbl$V1]
      colnames(testData_std_mean_tbl) <- tolower(featureList_std_mean_tbl$V2)
      trainData_std_mean_tbl <- trainData_tbl[featureList_std_mean_tbl$V1]
      colnames(trainData_std_mean_tbl) <- tolower(featureList_std_mean_tbl$V2)
      
      
      ## Read Test & Train Subject List 
      testSubject <- read.table(paste("./", folderName , "/test/subject_test.txt", sep = ""), header = FALSE) 
      colnames(testSubject) <- c("subject")
      trainSubject <- read.table(paste("./", folderName , "/train/subject_train.txt", sep = ""), header = FALSE)
      colnames(trainSubject) <- c("subject")
      
      ## Read Test & Train Activity List 
      testActivity <- read.table(paste("./", folderName , "/test/y_test.txt", sep = ""), header = FALSE) 
      ## Substituting Activity Code by Name 
      testActivity <- lapply(testActivity, function(x){activityLabel_tbl$V2[x]})
      
      
      #colnames(testActivity) <- "Activity"
      trainActivity <- read.table(paste("./", folderName , "/train/y_train.txt", sep = ""), header = FALSE)
      ## Substituting Activity Code by Name 
      trainActivity <- lapply(trainActivity, function(x){activityLabel_tbl$V2[x]})
      #colnames(trainActivity) <- "Activity"
      
      # Combine Subject | Activity | Subject Data 
      completeTestData <- bind_cols(testSubject, testActivity, testData_std_mean_tbl)
      completeTrainData <- bind_cols(trainSubject, trainActivity, trainData_std_mean_tbl)

      # Combine Test & Training Data
      completeDataSet <- bind_rows(completeTrainData, completeTestData)      

      completeDataSet_tbl <- tbl_df(completeDataSet)

      colnames(completeDataSet_tbl)[2] <- "activity"
      
      ## Writing Tidy Data to file
      write.table(completeDataSet_tbl, file = paste("./", folderName, "/tidyData.txt", sep=""), row.names = FALSE)
      

      ## Avg by Subject & Activity 
      avgCompleteDataSet <- group_by(completeDataSet_tbl, subject, activity) %>% summarise_each(funs(Avg="mean"))
      
      ## Writing Averaged Tidy Data to file 
      write.table(avgCompleteDataSet, file = paste("./", folderName, "/tidyAvgData.txt", sep = ""), row.names = FALSE)
      
      
}