library(dplyr)
library(stringr)

# save current directory

old.dir=getwd()

# check if 'UCI HAR Dataset' directory and required files exist. If not, unzip zip archive.

if( !(file.exists('UCI HAR Dataset') && file.exists('UCI HAR Dataset/train') &&
      file.exists('UCI HAR Dataset/test') && file.exists('UCI HAR Dataset/features.txt') &&
      file.exists('UCI HAR Dataset/activity_labels.txt') &&
      file.exists('UCI HAR Dataset/train/X_train.txt') &&
      file.exists('UCI HAR Dataset/train/y_train.txt') &&
      file.exists('UCI HAR Dataset/train/subject_train.txt') &&
      file.exists('UCI HAR Dataset/test/X_test.txt') &&
      file.exists('UCI HAR Dataset/test/y_test.txt') &&
      file.exists('UCI HAR Dataset/test/subject_test.txt')))
    unzip('UCI HAR Dataset.zip')

setwd('UCI HAR Dataset')

# read in feature names

fi <- read.table('features.txt')

# remove column of feature indices

fi <- fi[,2]

# read activity labels

al<-read.table('activity_labels.txt')

# remove column of activity label indicies
# format activity labels to lower case. Improve label descriptiveness.

al<-al[,2]
al<-tolower(al)
al[2]<-'climbingstairs'
al[3]<-'descendingstairs'

# load training features

setwd('train')
Xtrain<-read.table('X_train.txt')

# read training data activity labels

y_train<-read.table('y_train.txt')
colnames(y_train)<-'activity'

# select mean() and std() features only

Xtrainf<-Xtrain %>% select(as.array(grep("([M,m]ean|std)[(]+[)]+",fi)))

# transfer feature names to variable names

colnames(Xtrainf)<-tolower(gsub("[(]|[)]|-","",grep("([M,m]ean|std)[(]+[)]+",fi,value=TRUE)))

# load subject identifiers

subject_train<-read.table('subject_train.txt')
colnames(subject_train)<-'subject'

# prepend subject and activity factors to training data

Xtrainf<-bind_cols(subject_train,y_train,Xtrainf)

# read test data

setwd('../test')
Xtest<-read.table('X_test.txt')

# load test feature activity labels

y_test<-read.table('y_test.txt')
colnames(y_test)<-'activity'

# load subject identifiers

subject_test<-read.table('subject_test.txt')
colnames(subject_test)<-'subject'

# select mean() and std() features only

Xtestf<-Xtest %>% select(as.array(grep("([M,m]ean|std)[(]+[)]+",fi)))

# transfer feature names to variable names

colnames(Xtestf)<-tolower(gsub("[(]|[)]|-","",grep("([M,m]ean|std)[(]+[)]+",fi,value=TRUE)))

# prepend subject and activity factors to training data

Xtestf<-bind_cols(subject_test,y_test,Xtestf)

# stack training and test features together

Xtotal<-bind_rows(Xtrainf,Xtestf)

# replace activity labels with better descriptions

Xtotal<-Xtotal %>% mutate(activity=al[activity])

# save only complete cases

Xtotal<-Xtotal[complete.cases(Xtotal),]

# group feature measurements by subject and activity and then calculate the means
# of the features

Xmeans<-Xtotal %>% group_by(subject,activity) %>% summarize_each(funs(mean))

# revise the  revised dataframe's variable names to reflect the fact that they are means

colnames(Xmeans)<-c('subject','activity',gsub("^","mean",names(Xmeans)[3:68]))

# reformat the Xtotal and Xmeans to dataframes

Xtotal<-as.data.frame(Xtotal)
Xmeans<-as.data.frame(Xmeans)

# set the current working directory to the original directory

setwd(old.dir)