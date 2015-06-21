---
title: "README: Getting and cleaning data - project"
output: html_document
---

### What steps are made to make the data tidy
 
 
  
#### Libraries

The script requires the **dplyr** library.
```{r}
library(dplyr)
```


 
#### Read description files

The two files, *activity_labels.txt* and *features.txt* contain the list of activities and variables that will be used later in the script.

```{r}
activity_labels = read.table("activity_labels.txt", col.names = c("label", "activity"))
features = read.table("features.txt", col.names = c("label", "feature"))
```


 
#### Task 1

**Merge the training and the test sets to create one data set.**

In order to merge the two data sets, the first step is to read all the files. 

An example of the code that reads the files is: 
```{r}
subject_test = read.table("./test/subject_test.txt")
```

The *test* set contains the following files:

* subject_test
* X_test
* y_test
* body_acc_x_test
* body_acc_y_test
* body_acc_z_test
* body_gyro_x_test
* body_gyro_y_test
* body_gyro_z_test
* total_acc_x_test
* total_acc_y_test
* total_acc_z_test

The *train* set contains the following files:

* subject_train
* X_train
* y_train
* body_acc_x_train
* body_acc_y_train
* body_acc_z_train
* body_gyro_x_train
* body_gyro_y_train
* body_gyro_z_train
* total_acc_x_train
* total_acc_y_train
* total_acc_z_train

Then, the files were merged using the `cbind` function. An example of a code that merges two files is:

```{r}
subject = rbind(subject_test, subject_train)
```

From now on, the script will only work with the merged files. The *original* files are no longer needed. Those files are removed (*deleted*), although this last step is not mandatory. The example of a code that removes the *original* files is:

```{r}
remove(subject_test)
remove(subject_train)
```


 
#### Task 2

**Extract only the measurements on the mean and standard deviation for each measurement.**

First we need to get the names of all the variables (*features*)

```{r}
featuresList = features$feature
```

In the next step, the indices of features that contain either "mean()" or "std()" have been found. The two vectors (indices of *mean* and of *std*) are joined in a single vector `mean_std_cols`.

```{r}
mean_cols = grep("mean()", featuresList, fixed = TRUE)
std_cols = grep("std()", featuresList, fixed = TRUE)
mean_std_cols = c(mean_cols, std_cols)
```

The **X** data frame has been reshaped so that it only contains mean() and std() columns.

```{r}
X = select(X, mean_std_cols)
```


 
#### Task 3

**Use descriptive activity names to name the activities in the data set.**

The two files, *y* and *activity_labels* are joined with an activity label being a key. The goal is to join the activities with other variables. Furthermore, another column has been added, showing an information about the subject that the measurements were taken from.

```{r}
y_activities = left_join(y, activity_labels, by = c("V1" = "label"))
measured_activity = y_activities$activity
MSX = cbind(MSX, measured_activity, subject)
```

The **MSX** data frame now has two columns more, making it 68 now.


 
#### Task 4

**Appropriately label the data set with descriptive variable names.**

A document *tidy_col_names.txt* has been created, and this document contains the correct variable names. The descriptions of these variables can be found in the Code book.

```{r}
relevant_col_names = read.table("tidy_col_names.txt")
relevant_col_names = as.character(relevant_col_names$V1)
```

The last step is adding these descriptive names to the columns of the data frame.

```{r}
colnames(MSX) = c(relevant_col_names, "Activity", "Subject")
```


 
#### Task 5

**From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

The data frame **MSX** is grouped first by activity, then by subject.

```{r}
grouped_X = MSX %>% group_by(Activity, Subject)
```

In order to get the average of each variable for each activity and each subject, a function `summarise` is applied to the `grouped_X`, across all variables:

```{r}
  avg_summary = as.data.frame(summarise(grouped_X,
    m.t.BodyAcc.X = mean(m.t.BodyAcc.X),
    m.t.BodyAcc.Y = mean(m.t.BodyAcc.Y),
    .
    .
    .
    sd.f.FFT.BodyGyroMag = mean(sd.f.FFT.BodyGyroMag),
    sd.f.FFT.BodyGyroJerkMag = mean(sd.f.FFT.BodyGyroJerkMag)
  ))
```

The last step is to create a file that contains this summary.

```{r}
write.table(avg_summary, file = "Average by activity and subject.txt", row.names = FALSE)
```

The file *Average by activity and subject.txt* has later been uplaoded manually, as this last step was not supposed to be done by this script.