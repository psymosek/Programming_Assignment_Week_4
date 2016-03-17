# Programming_Assignment_Week_4

Demonstration of reformatting unstructured data files to tidy format

This repository contains an R script that maps the University of California
at Irvine "Human Activity Recognition Using Smartphones Data Set" into a
tidy data format. The R script, run_analysis.R, creates two dataframes:

   Xtotal - a dataframe containing all the training and testing
            mean and standard deviation accelerometer and gyroscope
	    measurements, plus the indexing variables of subject and the
	    measurement activity
   Xmeans - a dataframe containing the means of the mean and standard
            deviation accelerometer and gyroscope measurements, indexed
	    by subject and subject's measurement activity

The R script checks if the necessary text files exist in the local
directory 'UCI HAR Dataset' and, if they do not exist, it unzips the
zipfile 'UCI HAR Dataset.zip' which is included in this repository, to the
local directory.

