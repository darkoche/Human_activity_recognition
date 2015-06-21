# load libraries
  library(dplyr)

# read root files
  activity_labels = read.table("activity_labels.txt", col.names = c("label", "activity"))
  features = read.table("features.txt", col.names = c("label", "feature"))

# ---------------------------- TASK 1 ---------------------------- #
#   Merge the training and the test sets to create one data set.   #


# read test files
  subject_test = read.table("./test/subject_test.txt")
  X_test = read.table("./test/X_test.txt")
  y_test = read.table("./test/y_test.txt")
  body_acc_x_test = read.table("./test/Inertial Signals/body_acc_x_test.txt")
  body_acc_y_test = read.table("./test/Inertial Signals/body_acc_y_test.txt")
  body_acc_z_test = read.table("./test/Inertial Signals/body_acc_z_test.txt")
  body_gyro_x_test = read.table("./test/Inertial Signals/body_gyro_x_test.txt")
  body_gyro_y_test = read.table("./test/Inertial Signals/body_gyro_y_test.txt")
  body_gyro_z_test = read.table("./test/Inertial Signals/body_gyro_z_test.txt")
  total_acc_x_test = read.table("./test/Inertial Signals/total_acc_x_test.txt")
  total_acc_y_test = read.table("./test/Inertial Signals/total_acc_y_test.txt")
  total_acc_z_test = read.table("./test/Inertial Signals/total_acc_z_test.txt")

# read train files
  subject_train = read.table("./train/subject_train.txt")
  X_train = read.table("./train/X_train.txt")
  y_train = read.table("./train/y_train.txt")
  body_acc_x_train = read.table("./train/Inertial Signals/body_acc_x_train.txt")
  body_acc_y_train = read.table("./train/Inertial Signals/body_acc_y_train.txt")
  body_acc_z_train = read.table("./train/Inertial Signals/body_acc_z_train.txt")
  body_gyro_x_train = read.table("./train/Inertial Signals/body_gyro_x_train.txt")
  body_gyro_y_train = read.table("./train/Inertial Signals/body_gyro_y_train.txt")
  body_gyro_z_train = read.table("./train/Inertial Signals/body_gyro_z_train.txt")
  total_acc_x_train = read.table("./train/Inertial Signals/total_acc_x_train.txt")
  total_acc_y_train = read.table("./train/Inertial Signals/total_acc_y_train.txt")
  total_acc_z_train = read.table("./train/Inertial Signals/total_acc_z_train.txt")

# merge files
  body_acc_x = rbind(body_acc_x_test, body_acc_x_train)
  body_acc_y = rbind(body_acc_y_test, body_acc_y_train)
  body_acc_z = rbind(body_acc_z_test, body_acc_z_train)
  body_gyro_x = rbind(body_gyro_x_test, body_gyro_x_train)
  body_gyro_y = rbind(body_gyro_y_test, body_gyro_y_train)
  body_gyro_z = rbind(body_gyro_z_test, body_gyro_z_train)
  subject = rbind(subject_test, subject_train)
  total_acc_x = rbind(total_acc_x_test, total_acc_x_train)
  total_acc_y = rbind(total_acc_y_test, total_acc_y_train)
  total_acc_z = rbind(total_acc_z_test, total_acc_z_train)
  X = rbind(X_test, X_train)
  y = rbind(y_test, y_train)

# remove split files
  remove(body_acc_x_test)
  remove(body_acc_x_train)
  remove(body_acc_y_test)
  remove(body_acc_y_train)
  remove(body_acc_z_test)
  remove(body_acc_z_train)
  remove(body_gyro_x_test)
  remove(body_gyro_x_train)
  remove(body_gyro_y_test)
  remove(body_gyro_y_train)
  remove(body_gyro_z_test)
  remove(body_gyro_z_train)
  remove(subject_test)
  remove(subject_train)
  remove(total_acc_x_test)
  remove(total_acc_x_train)
  remove(total_acc_y_test)
  remove(total_acc_y_train)
  remove(total_acc_z_test)
  remove(total_acc_z_train)
  remove(X_test)
  remove(X_train)
  remove(y_test)
  remove(y_train)

# ------------------------TASK 1 COMPLETE ------------------------ #

###################################################################

# ---------------------------- TASK 2 ---------------------------- #
# Extract only the measurements on the mean and standard deviation #
#                     for each measurement.                        #

# get the list off features names (hold it in a vector featuresList)
  featuresList = features$feature

# find indices of those features that contain 'mean()' or 'std()'
  mean_cols = grep("mean()", featuresList, fixed = TRUE)
  std_cols = grep("std()", featuresList, fixed = TRUE)
  mean_std_cols = c(mean_cols, std_cols)

# reshape data frame so that it only contains mean() and std() columns
  X = select(X, mean_std_cols)

# ------------------------TASK 2 COMPLETE ------------------------ #

####################################################################

# ---------------------------- TASK 3 ---------------------------- #
#      Use descriptive activity names to name the activities       #
#                        in the data set.                          #

  y_activities = left_join(y, activity_labels, by = c("V1" = "label"))
  measured_activity = y_activities$activity
  X = cbind(X, measured_activity, subject)

# ------------------------TASK 3 COMPLETE ------------------------ #

####################################################################

# ---------------------------- TASK 4 ---------------------------- #
# Appropriately label the data set with descriptive variable names.#

# read the document that contains correct variable names
  relevant_col_names = read.table("tidy_col_names.txt")
  relevant_col_names = as.character(relevant_col_names$V1)


# add descriptive column names
  colnames(X) = c(relevant_col_names, "Activity", "Subject")

# ------------------------TASK 4 COMPLETE ------------------------ #

###################################################################

# ---------------------------- TASK 5 ---------------------------- #
#    From the data set in step 4, creates a second, independent    #
#       tidy data set with the average of each variable for        #
#                 each activity and each subject.                  #

  grouped_X = X %>% group_by(Activity, Subject)
  
  avg_summary = as.data.frame(summarise(grouped_X,
    m.t.BodyAcc.X = mean(m.t.BodyAcc.X),
    m.t.BodyAcc.Y = mean(m.t.BodyAcc.Y),
    m.t.BodyAcc.Z = mean(m.t.BodyAcc.Z),
    m.t.GravityAcc.X = mean(m.t.GravityAcc.X),
    m.t.GravityAcc.Y = mean(m.t.GravityAcc.Y),
    m.t.GravityAcc.Z = mean(m.t.GravityAcc.Z),
    m.t.BodyAccJerk.X = mean(m.t.BodyAccJerk.X),
    m.t.BodyAccJerk.Y = mean(m.t.BodyAccJerk.Y),
    m.t.BodyAccJerk.Z = mean(m.t.BodyAccJerk.Z),
    m.t.BodyGyro.X = mean(m.t.BodyGyro.X),
    m.t.BodyGyro.Y = mean(m.t.BodyGyro.Y),
    m.t.BodyGyro.Z = mean(m.t.BodyGyro.Z),
    m.t.BodyGyroJerk.X = mean(m.t.BodyGyroJerk.X),
    m.t.BodyGyroJerk.Y = mean(m.t.BodyGyroJerk.Y),
    m.t.BodyGyroJerk.Z = mean(m.t.BodyGyroJerk.Z),
    m.t.EN.BodyAccMag = mean(m.t.EN.BodyAccMag),
    m.t.EN.GravityAccMag = mean(m.t.EN.GravityAccMag),
    m.t.EN.BodyAccJerkMag = mean(m.t.EN.BodyAccJerkMag),
    m.t.EN.BodyGyroMag = mean(m.t.EN.BodyGyroMag),
    m.t.EN.BodyGyroJerkMag = mean(m.t.EN.BodyGyroJerkMag),
    m.f.FFT.BodyAcc.X = mean(m.f.FFT.BodyAcc.X),
    m.f.FFT.BodyAcc.Y = mean(m.f.FFT.BodyAcc.Y),
    m.f.FFT.BodyAcc.Z = mean(m.f.FFT.BodyAcc.Z),
    m.f.FFT.BodyAccJerk.X = mean(m.f.FFT.BodyAccJerk.X),
    m.f.FFT.BodyAccJerk.Y = mean(m.f.FFT.BodyAccJerk.Y),
    m.f.FFT.BodyAccJerk.Z = mean(m.f.FFT.BodyAccJerk.Z),
    m.f.FFT.BodyGyro.X = mean(m.f.FFT.BodyGyro.X),
    m.f.FFT.BodyGyro.Y = mean(m.f.FFT.BodyGyro.Y),
    m.f.FFT.BodyGyro.Z = mean(m.f.FFT.BodyGyro.Z),
    m.f.FFT.BodyAccMag = mean(m.f.FFT.BodyAccMag),
    m.f.FFT.BodyAccJerkMag = mean(m.f.FFT.BodyAccJerkMag),
    m.f.FFT.BodyGyroMag = mean(m.f.FFT.BodyGyroMag),
    m.f.FFT.BodyGyroJerkMag = mean(m.f.FFT.BodyGyroJerkMag),
    sd.t.BodyAcc.X = mean(sd.t.BodyAcc.X),
    sd.t.BodyAcc.Y = mean(sd.t.BodyAcc.Y),
    sd.t.BodyAcc.Z = mean(sd.t.BodyAcc.Z),
    sd.t.GravityAcc.X = mean(sd.t.GravityAcc.X),
    sd.t.GravityAcc.Y = mean(sd.t.GravityAcc.Y),
    sd.t.GravityAcc.Z = mean(sd.t.GravityAcc.Z),
    sd.t.BodyAccJerk.X = mean(sd.t.BodyAccJerk.X),
    sd.t.BodyAccJerk.Y = mean(sd.t.BodyAccJerk.Y),
    sd.t.BodyAccJerk.Z = mean(sd.t.BodyAccJerk.Z),
    sd.t.BodyGyro.X = mean(sd.t.BodyGyro.X),
    sd.t.BodyGyro.Y = mean(sd.t.BodyGyro.Y),
    sd.t.BodyGyro.Z = mean(sd.t.BodyGyro.Z),
    sd.t.BodyGyroJerk.X = mean(sd.t.BodyGyroJerk.X),
    sd.t.BodyGyroJerk.Y = mean(sd.t.BodyGyroJerk.Y),
    sd.t.BodyGyroJerk.Z = mean(sd.t.BodyGyroJerk.Z),
    sd.t.EN.BodyAccMag = mean(sd.t.EN.BodyAccMag),
    sd.t.EN.GravityAccMag = mean(sd.t.EN.GravityAccMag),
    sd.t.EN.BodyAccJerkMag = mean(sd.t.EN.BodyAccJerkMag),
    sd.t.EN.BodyGyroMag = mean(sd.t.EN.BodyGyroMag),
    sd.t.EN.BodyGyroJerkMag = mean(sd.t.EN.BodyGyroJerkMag),
    sd.f.FFT.BodyAcc.X = mean(sd.f.FFT.BodyAcc.X),
    sd.f.FFT.BodyAcc.Y = mean(sd.f.FFT.BodyAcc.Y),
    sd.f.FFT.BodyAcc.Z = mean(sd.f.FFT.BodyAcc.Z),
    sd.f.FFT.BodyAccJerk.X = mean(sd.f.FFT.BodyAccJerk.X),
    sd.f.FFT.BodyAccJerk.Y = mean(sd.f.FFT.BodyAccJerk.Y),
    sd.f.FFT.BodyAccJerk.Z = mean(sd.f.FFT.BodyAccJerk.Z),
    sd.f.FFT.BodyGyro.X = mean(sd.f.FFT.BodyGyro.X),
    sd.f.FFT.BodyGyro.Y = mean(sd.f.FFT.BodyGyro.Y),
    sd.f.FFT.BodyGyro.Z = mean(sd.f.FFT.BodyGyro.Z),
    sd.f.FFT.BodyAccMag = mean(sd.f.FFT.BodyAccMag),
    sd.f.FFT.BodyAccJerkMag = mean(sd.f.FFT.BodyAccJerkMag),
    sd.f.FFT.BodyGyroMag = mean(sd.f.FFT.BodyGyroMag),
    sd.f.FFT.BodyGyroJerkMag = mean(sd.f.FFT.BodyGyroJerkMag)
  ))
  
  write.table(avg_summary, file = "average_by_activity_and_subject.txt", row.names = FALSE)

# # ------------------------TASK 5 COMPLETE ------------------------ #