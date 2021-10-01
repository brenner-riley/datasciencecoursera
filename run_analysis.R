library(dplyr)

setwd("/Users/rileybrenner/Downloads/UCI HAR Dataset")
feature_labels <- read.table("/Users/rileybrenner/Desktop/Test/datasciencecoursera/UCI HAR Dataset/features.txt")

activity_labels <- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels)<-c("Code", "Activity")

#bax_test <- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
#bay_test<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
#baz_test<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
#bgx_test<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
#bgy_test<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
#bgz_test<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
#tax_test<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
#tay_test<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
#taz_test <- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")

stest <- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/X_test.txt")
y_text <- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/test/y_test.txt")

#bax_train <- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
#bay_train<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
#baz_train<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
#bgx_train<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
#bgy_train<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
#bgz_train<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
#tax_train<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
#tay_train<- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
#taz_train <- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

strain <- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("/Users/rileybrenner/Downloads/UCI HAR Dataset/train/y_train.txt")

#Combinations of all the derivative files, upon further consideration, 
# assignment only requires combination of the dataset with 561 variables.
#body_accel_x <- rbind(bax_test, bax_train)
#body_accel_y <- rbind(bay_test, bay_train)
#body_accel_y <- rbind(baz_test, baz_train)
#body_ang_velocity_x <- rbind(bgx_test, bgx_train)
#body_ang_velocity_y <- rbind(bgy_test, bgy_train)
#body_ang_velocity_z <- rbind(bgz_test, bgz_train)
#total_accel_x <- rbind(tax_test, tax_train)
#total_accel_y <- rbind(tay_test, tay_train)
#total_accel_z <- rbind(taz_test, taz_train)


##Combines relevant Data Files (1)
data_feature_vectors <- rbind(x_test, x_train)
test_identifiers <- rbind(y_text, y_train)
subject_identifiers <- rbind(stest, strain)
colnames(test_identifiers) <- "Activity"

##Extracts mean and standard deviation using apply (2)
data_means <- apply(data_feature_vectors, 2, mean)
data_sd <- apply(data_feature_vectors, 2, sd)


##Adds the string equivalent of the activity being performed by the subject into the 
##data_feature_vectore dataframe (3)
data_feature_vectors$ActivityCode <- test_identifiers
colnames(data_feature_vectors) <- c(1:561,"ActivityCode")
for(x in 1:nrow(data_feature_vectors))
{
  loc <- data_feature_vectors[x,562]
  data_feature_vectors[x,562] <- activity_labels[as.numeric(loc),2]
}

##Desriptive column names added where possible, for columns 1-561 of the data_feature_vectors data.frame, 
## no relevant data on what each column represents found. (4)



##New Data Frame that has the average of each variable for each participant/activity combination.
##Row name has participant and activity informaiton. (5)
temp <- data_feature_vectors
temp$Participant <- subject_identifiers

data_features_parcip_activity_avged <-data.frame()
row_nam <- c()
for(x in 1:30)
{
  for(y in 1:6)
  {
    info <- c(X, activity_labels[y,2])
    locs <- which(temp[562]==activity_labels[y,2] & temp[563] == x)
    data_features_parcip_activity_avged <- rbind(data_features_parcip_activity_avged, 
                                                 append(info,apply(data_feature_vectors[locs,1:561], 
                                                       2, mean), length(info)))
  }
}
row.names(data_features_parcip_activity_avged) <- row_nam
colnames(data_features_parcip_activity_avged) <- feature_labels[2]



write.table(data_features_parcip_activity_avged, file = "/Users/rileybrenner/Desktop/Test/datasciencecoursera/tidy.table.txt", row.name=FALSE )

