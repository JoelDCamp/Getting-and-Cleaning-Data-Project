#Step 1: This code requires the dplyr package

library(dplyr)


#Step 2: Set up initial objects and read the data 
#(Make sure you have the correct working directory active)
#(More objects will be introduced later, these keep track of the raw data)

testdata<-read.table("X_test.txt")
traindata<-read.table("X_train.txt")
subject_test<-readLines("subject_test.txt")
subject_train<-readLines("subject_train.txt")
y_test<-readLines("y_test.txt")
y_train<-readLines("y_train.txt")
features<-readLines("features.txt")


#Step 3: Combine the test and train sets into one data set using rbind()

Fulldata<-data.frame()
Fulldata<-rbind(testdata,traindata)


#Step 4: Set colnames for the Fulldata data frame from the features vector

colnames(Fulldata)<-features


#Step 5: Use grep() to create subsets of Fulldata for columns with names 
#which include either mean() and std()

Fulldata_means<-Fulldata[,grep("mean()",colnames(Fulldata))]
Fulldata_std<-Fulldata[,grep("std()",colnames(Fulldata))]


#Step 6: Combine Fulldata_means and Fulldata_std into one data set using cbind()

Filterdata<-data.frame()
Filterdata<-cbind(Fulldata_means,Fulldata_std)


#Step 7: Convert the numeric values for y_test and y_train into their corresponding 
#character strings using gsub()

y_test<-gsub(1,"Walking",y_test)
y_test<-gsub(2,"Walking Upstairs",y_test)
y_test<-gsub(3,"Walking Downstairs",y_test)
y_test<-gsub(4,"Sitting",y_test)
y_test<-gsub(5,"Standing",y_test)
y_test<-gsub(6,"Laying",y_test)

y_train<-gsub(1,"Walking",y_train)
y_train<-gsub(2,"Walking Upstairs",y_train)
y_train<-gsub(3,"Walking Downstairs",y_train)
y_train<-gsub(4,"Sitting",y_train)
y_train<-gsub(5,"Standing",y_train)
y_train<-gsub(6,"Laying",y_train)


#Step 8: Create data frames containing the subjects and activities for the
# test and train sets, then combine those sets

Test_Subject_Activity<-data.frame()
Test_Subject_Activity<-cbind(subject_test,y_test)

Train_Subject_Activity<-data.frame()
Train_Subject_Activity<-cbind(subject_train,y_train)

Subject_Activity<-data.frame()
Subject_Activity<-rbind(Test_Subject_Activity,Train_Subject_Activity)


#Step 9: Set the colnames for Subject_Activity

SA<-c("Subject","Activity")
colnames(Subject_Activity)<-SA


#Step 10: Combine the Subject_Activity data set with Filterdata using cbind()

Filterdata_id<-data.frame()
Filterdata_id<-cbind(Subject_Activity,Filterdata)


#Step 11: Group the data by Subject and then Activity using group_by()

groupeddata<-group_by(Filterdata_id,Subject,Activity)


#Step 12: Use summarise_each() with groupeddata to create the final tidy data set
#which lists the mean of each variable for each combination of Subject and Activity

Data_Summary<-summarise_each(groupeddata,funs(mean))
View(Data_Summary)

#You should now have your desired data set
