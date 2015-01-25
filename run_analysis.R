library(dplyr)

buildDataframe <- function(dir,subj_file,x_file,y_file) {
  
  #Read the subjects to the final dataframe(df)
  #----------------------
  df <- read.table(paste(dir, subj_file, sep=""), col.names = c("subject"))
  
  #Getting the activities vactor (descriptive activity names) and binding the vactor to the df
  #----------------------
  dfAct <- read.table(paste(dir,y_file,sep=""), col.names = c("activity"))
  actL <- read.table("activity_labels.txt", col.names = c("id", "label"))
  actL <- as.vector(actL$label)
  
  factorAct <- factor(as.vector(dfAct$activity), levels=1:length(actL) , labels=actL)
  df[,'activity'] <- as.vector(factorAct)
  
  #Getting the measurements (only the mean and std values), and bind measurements to the final data frame
  #----------------------
  measL <- read.table("features.txt", sep = " ", 
                      col.names = c("id", "vars"), header = FALSE)
  
  originalVars <- as.vector(measL$vars)
  meanAndStrIndexs <- grep("mean|std|Mean", measL$vars) 
  
  dfMeas <- read.table(paste(dir,x_file,sep=""), sep = "",  strip.white=TRUE,
                       col.names = originalVars, header = FALSE)
  dfMeas <- dfMeas[,meanAndStrIndexs]
  df <- cbind(df,dfMeas)
  
  df
}

run <- function() {
  #setwd("~/Documents/date-science/getdata/getdata-pa/data")
  print("Running analysis...")
  dfTrain <- buildDataframe("train/", 
                            "subject_train.txt", "X_train.txt", "y_train.txt");
  
  dfTest <- buildDataframe("test/", 
                            "subject_test.txt", "X_test.txt", "y_test.txt");
  
  #bind the two data frames 
  df <- rbind(dfTrain,dfTest)
  
  #Summaraise the data by mean grouped by activity and subject
  byActSub <- group_by(df, activity, subject) %>% summarise_each(funs(mean))
  
  #Write df to a file
  write.csv(byActSub, file = "tidy.txt")
  print("End.")
}

#run the script
#run()

