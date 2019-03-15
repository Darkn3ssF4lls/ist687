#############################################################################
#Name: Daniel Lewis
#Description: Homework Assignment 9
#Date: 3/14/19 (JST)
#input: 
#output: 
#update history:
#############################################################################
#####################HW9: Support Vector Machines Lab########################
#############################################################################
#
#############################################################################
############################LOCAL FUNCTIONS##################################
#############################################################################
#
EnsurePackage<-function(x){
   x<-as.character(x)
   if (!require(x,character.only=TRUE)){
       install.packages(pkgs=x, repos="http://cran.r-project.org")
       require(x, character.only=TRUE)
     }
}
Numberize <- function(inputVector){
  inputVector <-gsub(",","",inputVector)
  inputVector <- gsub(" ", "", inputVector)
  inputVector <-  as.numeric(inputVector)
}
#
#############################################################################
#############################IMPORTS SECTION#################################
#############################################################################
#Packages#

#############################################################################
#############################Problems Solved#################################
#############################################################################
#
#Step 1:Load the data
myAiraulity <- airquality
colnames(myAirquality)[colSums(is.na(myAirquality))>0]
myAirquality$Ozone[is.na(myAirquality$Ozone)] <- mean(myAirquality$Ozone, na.rm=TRUE)
myAirquality$Solar.R[is.na(myAirquality$Solar.R)] <- mean(myAirquality$Solar.R, na.rm=TRUE)

#Step 2: Create train and test data sets


#
#
#END OF SCRIPT