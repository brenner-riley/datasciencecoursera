This is the associated README file for the final course project for the Data Getting and Cleaning course on Coursera.

This analysis was performed on the data in the following zip: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .

All data files have associated read lines in the run_analysis file, though many are commented out as they were deemed to be outside the scope of the project.

Combined files were creating using rbind, with consideration of the order of the composed files being maintained. Files of different data were combined at different points.

apply allowed for easy computation of row means and standard deviations.

For loops used to run through data, for value replacement and grouping reasons, for both requirements (3) and (4).

activity_labels 
      data.frame read from file that denotes the Activity that each numerical activity code denotes.
stest
      The subject codes associated with the test data. Variable type data.frame.
x_test
      Raw censor data associted with the test data. Variable type data.frame.
y_text
      The activity codes assocuated with the test data. Variable type data.frame.
strain 
      The subject codes assocuated with the training data. Variable type data.frame.
x_train 
      Raw censor data assocuated with the training data. Variable type data.frame.
y_train 
      The activity codes associated with the training data. Variable type data.frame.
data_feature_vectors  
      The combined data file derived from x_test and x_train. Variable type data.frame.
test_identifiers
      The combined activity data derived from the y_text and y_train data. Variable type data.frame.
subject_identifiers
      The combined subject data derived from the stest and strain data. Variable type data.frame.
data_means
      Numeric vector that measures the mean/avg value of each censor in the data_feature_vectors data.frame.
data_sd 
      Numeric vector that measures the standard deviation of each censor in the data_feature_vectors data.frame.
data_features_parcip_activity_avged
      data.frame that lists the average censor values based on the performance of each participant in each test.

