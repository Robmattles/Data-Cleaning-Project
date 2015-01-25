First, the code reads in the entire UCI HAR Dataset from all relevant files.  It binds all variables together using cbind.  Then it binds the test and training set together using rbind.  At this point, all the data from the dataset is in one dataframe.

Then it generates column headers for each variable.  The first two are generated manually and labeled as Subject Number and Activity.  The 561 features are labeled from the features.txt file, which had previously been read in with other relevant files.  Then the raw data variables are labeled by data type (i.e. total acceleration) and axis and assigned a numerical index based on their position in the initial data.

The data is then merged with a key that identifies the activity based on the numerical code in the raw data.

Then, all feature variables that are not standard deviations or means are removed via a for loop that tests the name of each variable to see if it contains std or mean.  If the name does not contain either, the feature variable is deleted.

Following the deletion of unnecessary columns, more descriptive names of the existing feature variables are generated.  Feature variable names are looped over and abbreviations are replaced with full terms and connecting words are added to make them easier to read.

Finally, the aggregate function is used create a second, independent tidy data set with the average of each variable for each activity and each subject.
