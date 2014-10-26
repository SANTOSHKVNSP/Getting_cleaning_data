X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
Y_train<-read.table("UCI HAR Dataset/train/Y_train.txt")
Y_test<-read.table("UCI HAR Dataset/test/Y_test.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
col_names<-read.table("UCI HAR Dataset/features.txt")
col_names<-as.character(col_names[[2]])
colnames(X_test)<-col_names
colnames(X_train)<-col_names
X_test1<-X_test[,grep("(mean\\(|std)",col_names)]
X_train1<-X_train[,grep("(mean\\(|std)",col_names)]
for(i in label_names$V1) {
  Y_test[Y_test==i] <-as.character(label_names[[2]][i])
  Y_train[Y_train==i] <-as.character(label_names[[2]][i])
}
X_combined<-cbind(rbind(X_test1,X_train1),rbind(Y_test,Y_train))
names(X_combined)[67:68] <- c("activity_name","subject")
tbl_final2 <- group_by(X_combined,subject,activity_name)
tbl_final <-summarise_each(tbl_final2,funs(mean))
write.table(tbl_final,row.names=FALSE)
write.table(tbl_final,row.names=FALSE,file="tidy_data.txt")
