# getdata-pa
This run_analysis.R script cleans and summarises the data collected from the accelerometers from the Samsung Galaxy S smartphone. The original data can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script build the final data with the following steps:
##### Dataframes building (train/test)
 - The function 'buildDataframe' reads subject txt file (subject_train.txt, subject_test.txt) and creates a final dataframe with the 'subject' varibale 
 - The the function reads the activities ids file (y_train.txt, y_test.txt) to a vector, replace the numeric values to the labels values(activity_labels.txt), using the factor function. 
 - Creates a colunm called 'activity' in the final dataframe and binds the vector above to that colunm.
 - Reads the measurements values (X_train.txt, X_test.txt) to a mesuremnts dataframe, using the "eatures.txt"file the function cuts the mesuremnts df with only mean and std variables.
 - Then the function binds the final dataframe with the mesuremnts dataframe.
 
##### Binding and summarising
 - The script builds two dataframes with the steps above, the test df and the train df, then the two dataframes are joined
 - The joined dataframe are grouped by activity and subject, computing the mean of the measurements variables.

