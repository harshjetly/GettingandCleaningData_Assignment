# GettingandCleaningData_Assignment

## run_analysis script

### Transformation to create TidyData file 
- Takes the folder destination as an input
- Reads in the feature list & activity file & filters only the variables that are related to standard deviation or mean 
- a filtered tibble with only variable index and name is created
- The X_test & X_train files are read and loaded 
- train & test data is filtered only to keep the variables that are std or mean related 
- the activity & subject data is added to the filtered test & train data using the bind_cols
- colnames are provided from the featurelist file and subject & activity 
- test & train data is merged using the bind_rows function 
- the tidy file is written to **tidyData.txt**


### Transformation to create TidyData Average file 
- The data is grouped by subject & activity
- Using grouping and chaining the data is averaged for each activity of a subject
- the tidy file is written to **tidyAvgData.txt**


##Four files are a part of this assignment 
 
- 1. run_analysis.R - This is the script file, that performs all the transformations & creates the two tidy files 
- 2. tidyData.txt - This file contains a tidy data set of combined results from training and test data. The file contains subject, activity
mean, std for each variable. 
- 3. tidyAvgData.txt - This file contains the Avg by Subject & Activity
- 4. CodeBook.md - Explains the script run_analysis.R
