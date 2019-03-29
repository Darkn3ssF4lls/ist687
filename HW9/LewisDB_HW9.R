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
EnsurePackage("arules")
EnsurePackage("kernlab")
EnsurePackage("ggplot2")
EnsurePackage("colorspace")
EnsurePackage("e1071")
EnsurePackage("gridExtra")
EnsurePackage("grid")
EnsurePackage("lattice")

#############################################################################
#############################Problems Solved#################################
#############################################################################
#
#Step 1:Load the data
myAirquality <- airquality
colnames(myAirquality)[colSums(is.na(myAirquality))>0]
myAirquality$Ozone[is.na(myAirquality$Ozone)] <- mean(myAirquality$Ozone, na.rm=TRUE)
myAirquality$Solar.R[is.na(myAirquality$Solar.R)] <- mean(myAirquality$Solar.R, na.rm=TRUE)

#Step 2: Create train and test data sets
randomized <-sample(1:dim(myAirquality)[1])
trimmed <- floor(2*dim(myAirquality)[1]/3)

toddler <- myAirquality[randomized[1:trimmed],]
alphatester <- myAirquality[randomized[(trimmed+1):dim(myAirquality)[1]],]


#Step 3: Build a Model using KSVM & visualize the results

mykvsm <- ksvm(Ozone ~., data=toddler,kernel="rbfdot", kpar="automatic",C=5,cross=3,prob.model=TRUE)
mykvsm_predict <- predict(mykvsm,alphatester,type="response")
mykvsm_predict

RMSE = function(m,o){
  sqrt(mean((m-o)^2))
}

toddler$RMSE_Ozone <- RMSE(alphatester$Ozone,mykvsm_predict)

step3_gg <-ggplot(toddler,aes(x=Temp,y=Wind)) +geom_point(aes(size=RMSE_Ozone,color=Ozone))+ ggtitle("Step 3 Air Quality 1")
step3_gg

step3_lm <- lm(formula = myAirquality$Ozone ~., data=myAirquality)
summary(step3_lm)

step3_lm2 <- lm(formula = myAirquality$Ozone ~myAirquality$Solar.R+myAirquality$Wind+myAirquality$Temp, data=myAirquality)
summary(step3_lm2)

myAirquality_v2 <- myAirquality

myAirquality_v2$LM <- (myAirquality$Solar.R*0.05775-myAirquality$Wind*2.71725+myAirquality$Temp*1.24126-38.22315)

myAirquality_v2$RMSE_Ozone <- RMSE(myAirquality_v2$Ozone,myAirquality_v2$LM)
myAirquality_v2$RMSE_Ozone  

step3_gg2<-ggplot(myAirquality_v2,aes(x=Temp,y=Wind)) +geom_point(aes(size=RMSE_Ozone,color=Ozone))+ ggtitle("Step 3 Linear Model Air Quality")
step3_gg2

grid.arrange(step3_gg, step3_gg2)

#Step 4: Create a 'goodOzone' variable
myAirquality_v3<-myAirquality

myAirquality_v3$goodOzone <- ifelse(myAirquality_v3$Ozone <= mean(myAirquality_v3$Ozone), 0, 1)


randomized2 <-sample(1:dim(myAirquality_v3)[1])
trimmed2 <- floor(2*dim(myAirquality_v3)[1]/3)

toddler2 <- myAirquality_v3[randomized2[1:trimmed2],]
betatester <- myAirquality_v3[randomized2[(trimmed2+1):dim(myAirquality_v3)[1]],]


# Step 5: See if we can do a better job predicting 'good' and 'bad' days


step5_svm <- ksvm(goodOzone ~ toddler2$Solar.R+toddler2$Wind+toddler2$Temp, data=toddler2,kernel="rbfdot", kpar="automatic",C=5,cross=3,prob.model=TRUE)

step5_predict <- predict(step5_svm,betatester,type="response")
step5_predict
betatester

step5_gg<-ggplot(toddler2,aes(x=Temp,y=Wind)) +geom_point(aes(size=RMSE_Ozone,color=Ozone))+ ggtitle("Final Graph")
step5_gg
#
#
#END OF SCRIPT