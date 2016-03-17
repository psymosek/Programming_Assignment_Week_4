The transformations executed by the script, in order, are:

1. save current directory
2. check if 'UCI HAR Dataset' directory and required files exist. If not,
   unzip zip archive.
3. read in feature names 'features.txt'
4. remove column of feature indices
5. read activity labels 'activity_labels.txt'
6. remove column of activity label indicies
7. format activity labels to lower case. Improve label descriptiveness.
8. load training features 'X_train.txt'
9. read training data activity labels 'y_train.txt
10. select mean() and std() features only
11. transfer feature names to variable names
12. load subject identifiers 'subject_training.txt'
13. prepend subject and activity factors to training data
14. read test data 'X_test.txt'
15. load test feature activity labels 'y_test.txt'`
16. load subject identifiers 'subject_test.txt'
17. select mean() and std() features only
18. transfer feature names to variable names
19. prepend subject and activity factors to testing data
20. stack training and test features together
21. replace activity labels with better descriptions
22. save only complete cases
23. group feature measurements by subject and activity and then calculate
    the means of the features
24. revise the  revised dataframe's variable names to reflect the fact
    that they are means
25. reformat the Xtotal and Xmeans to dataframes
26. set the current working directory to the original directory
