---
title: "CodeBook"
author: "Darko Čengija"
date: "21. June, 2015."
output: html_document
---

## The Code book for the analysis

### General description of variables

Each variable (column) contains 180 records, each representing an average value of that variable for one of the 30 subjects in one of 6 activities.

There are 33 varibles in total, and for each one a **mean** and a **standard deviation** has been calculated, making it 66 columns in total.

The column names that start with **m.** represent the **means**, while those that start with **sd.** represent **standard deviations**. For any variable, its unit of measurement is the same in the **m** column and **sd** column.

Each variable also carries an additional marking of either **t.** (time domain signals, meaning X axis is time), or **f.FFT.** (frequency domain signals, calculated by a Fast Fourier Transform).

Fast Fourier Transform is an algorithm to compute discrete Fourier transform, which is summing discrete values (of the variable) with coefficients. **The unit of measurement remains the same.**

### Variables explained

#### Body acceleration - **BodyAcc**
* m.t.BodyAcc.X
* m.t.BodyAcc.Y
* m.t.BodyAcc.X

*The acceleration signals were separated into Body and Gravity acceleration signals, to distunguish the contribution between the two. These three variables represent the mean of body acceleration in all three directions. The unit of measurement is* **m/s2**. 
*The variables that start with* **sd** *represent standard deviation of body acceleration. The unit of measurement is the same*.

#### Gravity acceleration - **GravityAcc**
* m.t.GravityAcc.X
* m.t.GravityAcc.Y
* m.t.GravityAcc.Z

*These three variables represent the Gravitational acceleration in all three directions. The unit of measurement is* **m/s2**. 
*The variables that start with* **sd** *represent standard deviation of gravitational acceleration. The unit of measurement is the same*.

#### Body acceleration jerk - **BodyAccJerk**
* m.t.BodyAccJerk.X
* m.t.BodyAccJerk.Y
* m.t.BodyAccJerk.Z

*The acceleration jerk is the change in acceleration over time. These variables represent the change of body acceleration over time in all three directions. The change of acceleration over time means we are calculating* **acceleration/s**. *As the unit of acceleration is* **m/s2** *, the unit of acceleration jerk is* **(m/s2)/s** *, which is* **m/s3**.
*The variables that start with* **sd** *represent standard deviation of body acceleration jerk. The unit of measurement is the same*.

#### Body angular velocity - **BodyGyro**
* m.t.BodyGyro.X
* m.t.BodyGyro.Y
* m.t.BodyGyro.Z

*The angular velocity is the rate of change of angular displacement. It represents the amount of (change in) angle over time. The unit of measurement is* **angle/s**.
*The variables that start with* **sd** *represent standard deviation of angulary velocity. The unit of measurement is the same*.

#### Body angular velocity jerk - **BodyGyroJerk**
* m.t.BodyGyroJerk.X
* m.t.BodyGyroJerk.Y
* m.t.BodyGyroJerk.Z

*The angular velocity jerk is the change in angular velocity over time, in all three directions. It is basically* **angular_velocity/s**. *As the unit of angular velocity is* **angle/s**, *the unit of angular velocity jerk is thus* **angle/s2**.
*The variables that start with* **sd** *represent standard deviation of angular velocity jerk. The unit of measurement is the same*.

#### Magnitude of signals - **...Mag**
* m.t.EN.BodyAccMag
* m.t.EN.GravityAccMag
* m.t.EN.BodyAccJerkMag
* m.t.EN.BodyGyroMag
* m.t.EN.BodyGyroJerkMag

*The magnitude of the three dimensional signals we calculated using the Euclidean norm. The Euclidean norm assigns to each vector the length of its arrow. As a result, we get a number that tells us how "long" the vector is. The length of a vector is calculated as* 
**length = sqrt(X2 + Y2 + Z2)**. 
*The combined operations of square and square root will preserve the unit of measurement for each of the variables.*
*The variables that start with* **sd** *represent standard deviation of each magnitude. The unit of measurement remains unchanged*.

#### Fast Fourier Transform - **m.f.FFT....**
* m.f.FFT.BodyAcc.X, m.f.FFT.BodyAcc.Y, m.f.FFT.BodyAcc.Z
* m.f.FFT.BodyAccJerk.X, m.f.FFT.BodyAccJerk.Y, m.f.FFT.BodyAccJerk.Z
* m.f.FFT.BodyGyro.X, m.f.FFT.BodyGyro.Y, m.f.FFT.BodyGyro.Z
* m.f.FFT.BodyAccMag
* m.f.FFT.BodyAccJerkMag
* m.f.FFT.BodyGyroMag
* m.f.FFT.BodyGyroJerkMag

*The Fast Fourier Transform is a powerful mathematical tool that allows you to see the signals in a different domain (frequency domain, rather than time domain). Basically, you see a distribution of signals across the frequencies, rather than its change over time.*

*The Fast Fourier Transform* **preserves** *the unit of measurement, so each of the variables listed below are unchanged in that respect.*

*The variables that start with* **sd** *represent standard deviation for each variable. The unit of measurement is of course unchanged*.