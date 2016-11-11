#Code Book 

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

