#############################################################################
#Name: Daniel Lewis
#Description: Homework Assignment 8
#Date: 3/8/19 (JST)
#input: 
#output: 
#update history:
#############################################################################
#####################HW7: Viz Map HW: Median Income##########################
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
EnsurePackage("RCurl")
EnsurePackage("ggplot2")
EnsurePackage("ggmap")
EnsurePackage("RJSONIO")
EnsurePackage("reshape2")
EnsurePackage("mapproj")
EnsurePackage("moments")
EnsurePackage("readxl")
EnsurePackage("gdata")
#DataSets#
urlToImport <-"http://college.cengage.com/mathematics/brase/understandable_statistics/7e/students/datasets/mlr/excel/mlr01.xls"
importedXLS <- data.frame(read.xls(urlToImport)
#
#############################################################################
#############################Problems Solved#################################
#############################################################################
#
#1. Read in data from the following URL: http://college.cengage.com/mathematics/brase/understandable_statistics/7e/students/datasets/mlr/excel/mlr01.xls
#This URL will enable you to download the dataset into excel.
#The more general web site can be found at: http://college.cengage.com/mathematics/brase/understandable_statistics/7e/students/datasets/mlr/frames/frame.html
#If you view this in a spreadsheet, you will find that four columns of a small dataset.
#The first column shows the number of fawn in a given spring (fawn are baby Antelope). The second 
#column shows the population of adult antelope, the third shows the annual precipitation 
#that year, and finally, the last column shows how bad the winter was during that year.
#
#assign thouse column names above
colnames(importedXLS)<-c("fawn", "adult","precip","winter")
#
#2. You have the option of saving the file save this file to your computer and read it into
#R, or reading the data directly from the web into a data frame.
#
#display the data
head(importedXLS)
#
#3. You should inspect the data using the str() command to make sure that all of the
#cases have been read in (n=8 years of observations) and that there are four
#variables.
#
str(importedXLS)
#
#4. Create bivariate plots of number of baby fawns versus adult antelope population,
#the precipitation that year, and the severity of the winter. Your code should produce
#three separate plots. Make sure the Y-axis and X-axis are labeled. Keeping in mind
#that the number of fawns is the outcome (or dependent) variable, which axis should
#it go on in your plots?
#
#Generate plot of baby fawns vs adaults
step4Plot <- ggplot(data=importedXLS, aes(y=fawn, x=adult)) + geom_point()
step4Plot <- step4Plot + ylab("Spring Fawn Count/100") + xlab("Size of Adult Antelope Population/100")
step4Plot <- step4Plot + ggtitle("Thunder Basin Antelope Study (Fawn to Adult)")
#Generate plot of baby fawns vs precipitation
step4Plot2 <- ggplot(data=importedXLS, aes(y=fawn, x=percip)) + geom_point()
step4Plot2 <- step4Plot2 + ylab("Spring Fawn Count/100") + xlab("Annual Preciptiaton('Inches')")
step4Plot2 <- step4Plot2 + ggtitle("Thunder Basin Antelope Study (Fawn to Annual Preciptiation)")
#Generate plot of baby fawns vs winter
step4Plot3 <- ggplot(data=importedXLS, aes(y=fawn, x=winter)) + geom_point()
step4Plot3 <- step4Plot3 + ylab("Spring Fawn Count/100") + xlab("Winter Severity Index (1=mild 5=Severe)")
step4Plot3 <- step4Plot3 + ggtitle("Thunder Basin Antelope Study (Fawn to Winter Severity)")
#print the plots
step4Plot
step4Plot2
step4Plot3
#thought question answer
print("The dependent variable should go upon the y axis and the independant should go on the x.")
#
#5. Next, create three regression models of increasing complexity using lm(). In the first
#model, predict the number of fawns from the severity of the winter. In the second
#model, predict the number of fawns from two variables (one should be the severit of the winter). 
#In the third model predict the number of fawns from the three other variables. Which model works 
#best? Which of the predictors are statistically significant in each model? If you wanted to create
#the most parsimonious model (i.e., the one that did the best job with the fewest predictors), 
#what would it contain?
#
#generate a basic lm
plot(importedXLS$fawn, importedXLS$winter, ylab="Spring Fawn Count/100", xlab="Winter Severity Index (1=mild 5=Severe)", main="Thunder Basin Antelope Study (Fawn to Winter Severity)")
lm1<-lm(formula = fawn~winter, importedXLS)
abline(lm1)
str(lm1)
#generate a two variable rm
twoVariablesPlot <- ggplot(data=importedXLS, aes(y=fawn, x=winter+percip)) + geom_point()
twoVariablesPlot <- twoVariablesPlot + ylab("Spring Fawn Count/100") + xlab("Winter Severity and Percipitation")
twoVariablesPlot <- twoVariablesPlot + ggtitle("Thunder Basin Antelope Study (Fawn to Two Variables)")
twoVariablesPlot
lm2 <- lm(forumla=fawn~winter+precip, importedXLS)
str(lm2)
twoVariablesPlot + abline(lm2)
#generate a three variable lm
allVariablesPlot <- ggplot(data=importedXLS, aes(y=fawn, x=winter+percip+adult)) + geom_point()
allVariablesPlot <- allVariablesPlot + ylab("Spring Fawn Count/100") + xlab("Winter Severity and Percipitation and Adult")
allVariablesPlot <- allVariablesPlot + ggtitle("Thunder Basin Antelope Study (Fawn to All Variables)")
allVariablesPlot
lm3 <- lm(forumla=fawn~., importedXLS)
str(lm3)
allVariablesPlot + abline(lm2)
#
#The better of these will be the two variable as the one including all the fields will produce a lower probiblity value. 
#
#END OF SCRIPT