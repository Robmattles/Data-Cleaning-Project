X_train=read.table("~/UCI HAR Dataset/train/X_train.txt")
X_test=read.table("~/UCI HAR Dataset/test/X_test.txt")
activityLabels=read.table("~/UCI HAR Dataset/activity_labels.txt")
varLabels=read.table("~/UCI HAR Dataset/features.txt")
X_test=cbind(scan("~/UCI HAR Dataset/test/y_test.txt"),X_test)
X_train=cbind(scan("~/UCI HAR Dataset/train/y_train.txt"),X_train)
names(activityLabels)=c("code","ActivityName")
X_train=cbind(scan("~/UCI HAR Dataset/train/subject_train.txt"),X_train)
X_test=cbind(scan("~/UCI HAR Dataset/test/subject_test.txt"),X_test)
library(reshape2)

accel_x_test=read.table("~/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
accel_y_test=read.table("~/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
accel_z_test=read.table("~/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")
accel_x_train=read.table("~/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
accel_y_train=read.table("~/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
accel_z_train=read.table("~/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

gyro_x_test=read.table("~/UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
gyro_y_test=read.table("~/UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
gyro_z_test=read.table("~/UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
gyro_x_train=read.table("~/UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
gyro_y_train=read.table("~/UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
gyro_z_train=read.table("~/UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")

body_acc_x_test=read.table("~/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test=read.table("~/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test=read.table("~/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
body_acc_x_train=read.table("~/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train=read.table("~/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train=read.table("~/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")

X_test=cbind(X_test,accel_x_test,accel_y_test,accel_z_test,gyro_x_test,gyro_y_test,gyro_z_test,body_acc_x_test,body_acc_y_test,body_acc_z_test)
X_train=cbind(X_train,accel_x_train,accel_y_train,accel_z_train,gyro_x_train,gyro_y_train,gyro_z_train,body_acc_x_train,body_acc_y_train,body_acc_z_train)
names(X_test)[1]<-"x1"
names(X_test)[2]<-"x2"
names(X_train)[1]<-"x1"
names(X_train)[2]<-"x2"
fullSet<-rbind(X_test,X_train)
labels=c("Subject_Number","Activity")
for (i in 1:561){labels<-c(labels,as.character(varLabels$V2[i]))}
for (i in 1:128){labels<-c(labels,paste("Total acceleration on x axis component ",toString(i)));}
for (i in 1:128){labels<-c(labels,paste("Total acceleration on y axis component ",toString(i)));}
for (i in 1:128){labels<-c(labels,paste("Total acceleration on z axis component ",toString(i)));}
for (i in 1:128){labels<-c(labels,paste("Angular velocity on x axis component ",toString(i)));}
for (i in 1:128){labels<-c(labels,paste("Angular velocity on y axis component ",toString(i)));}
for (i in 1:128){labels<-c(labels,paste("Angular velocity on z axis component ",toString(i)));}
for (i in 1:128){labels<-c(labels,paste("Body acceleration on x axis component ",toString(i)));}
for (i in 1:128){labels<-c(labels,paste("Body accelaration on y axis component ",toString(i)));}
for (i in 1:128){labels<-c(labels,paste("Body accelaration on z axis component ",toString(i)));}
names(fullSet)<-labels
fullSet<-merge(fullSet,activityLabels,by.x="Activity",by.y="code")
goodNames=grepl("std|mean",names(fullSet));
count=0
for (i in 3:563){
  if (!goodNames[i]) {
    fullSet[,i-count]<-NULL
    count=count+1;
  }
}
newnames=names(fullSet)
for (i in 1:length(names(fullSet))){
  if (substr(names(fullSet)[i],1,1)=="t" |substr(names(fullSet)[i],1,1)=="f") {
    newnames[i]<-""
    if (substr(names(fullSet)[i],1,1)=="f"){newnames[i]=paste(newnames[i], "Transformed")}
    if (grepl("std",names(fullSet)[i])){newnames[i]=paste(newnames[i], " Standard Deviation of")}
    if (grepl("mean",names(fullSet)[i])){newnames[i]=paste(newnames[i], " Mean")}
    
    
    if (grepl("Acc",names(fullSet)[i])){newnames[i]=paste(newnames[i], " Accelerometer")}
    if (grepl("Gyro",names(fullSet)[i])){newnames[i]=paste(newnames[i], " Gyroscope")}
    if (grepl("Jerk",names(fullSet)[i])){newnames[i]=paste(newnames[i], " Jerk")}
    else {newnames[i]=paste(newnames[i], " Raw")}
    newnames[i]=paste(newnames[i], " Signal")
    if (grepl("Mag",names(fullSet)[i])){newnames[i]=paste(newnames[i], " Magnitude")}
    if (grepl("Body",names(fullSet)[i])){newnames[i]=paste(newnames[i], "from Body")}
    if (grepl("Gravity",names(fullSet)[i])){newnames[i]=paste(newnames[i], "from Gravity")}        
    if (grepl("X",names(fullSet)[i])){newnames[i]=paste(newnames[i], "on X Axis")} 
    if (grepl("Y",names(fullSet)[i])){newnames[i]=paste(newnames[i], "on Y Axis")} 
    if (grepl("Z",names(fullSet)[i])){newnames[i]=paste(newnames[i], "on Z Axis")}         
  }
}
names(fullSet)<-newnames        
fullSet$Activity<-fullSet$ActivityName
fullSet$ActivityName<-NULL
aggdata <-aggregate(fullSet, by=list(fullSet$Activity,fullSet$Subject_Number),  FUN=mean, na.rm=TRUE)
write.table(aggdata,"Summarized Data.txt",row.names=FALSE)
write.table(fullSet,"Full Data Set.txt",row.names=FALSE)
