#############################################################################
#Name: Daniel Lewis
#Description: Homework Assignment 5
#Date: 2/15/19 (JST)
#input: 
#output: 
#update history:
#############################################################################
###################HW6 Viz HW: air quality Analysis##########################
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
Numberize <- function(inputVector)
{
  inputVector <- gsub(",", "", inputVector)
  inputVector <- gsub(" ", "", inputVector)
  return(inputVector)
}
na.numeric<-function(input){
  for(i in 1:ncol(input)){
    data[is.na(input[,i]), i] <- mean(data[,i], na.rm=TRUE)  
  }
  return(input)
}

#
#############################################################################
#############################IMPORTS SECTION#################################
#############################################################################
#
EnsurePackage("ggplot2")
EnsurePackage("ggmap")
EnsurePackage("RJSONIO")
EnsurePackage("RCurl")
EnsurePackage("reshape2")
EnsurePackage("sqldf")
#
#############################################################################
#############################Problems Solved#################################
#############################################################################
#
#
#Step 1: Load the data 
#We will use the air quality data set, which you should already have as part of your R installation.
#
myAirquality<-airquality

#
#Step 2: Clean the data
#After you load the data, there will be some NAs in the data. You need to figure out what to do
#about those nasty NAs.
#
colnames(myAirquality)[colSums(is.na(myAirquality))>0]
myAirquality$Ozone[is.na(myAirquality$Ozone)] <- mean(myAirquality$Ozone, na.rm=TRUE)
myAirquality$Solar.R[is.na(myAirquality$Solar.R)] <- mean(myAirquality$Solar.R, na.rm=TRUE)
#
#Step 3: Understand the data distribution
#Create the following visualizationsusing ggplot:
#.Histograms for each of the variables
#
ozone_hist<- ggplot(myAirquality, aes(x=Ozone)) + geom_histogram(bins=5, color="black", fill="white")
ozone_hist<- ozone_hist+ggtitle("Ozone Levels in 1973")
solar_hist<- ggplot(myAirquality, aes(x=Solar.R)) + geom_histogram(bins=5, color="black", fill="white")
solar_hist<- solar_hist+ggtitle("Solar Levels in 1973")
wind_hist<- ggplot(myAirquality, aes(x=Wind)) + geom_histogram(bins=5, color="black", fill="white")
wind_hist<- wind_hist+ggtitle("Wind Levels in 1973")
temp_hist<- ggplot(myAirquality, aes(x=Temp)) + geom_histogram(bins=5, color="black", fill="white")
temp_hist<- temp_hist+ggtitle("Temp Levels in 1973")
ozone_hist
solar_hist
wind_hist
temp_hist
#
#.Boxplot for Ozone
#
ozone_box<- ggplot(myAirquality, aes(x=factor(0),Ozone)) +geom_boxplot() + ggtitle("Ozone Box Plot")
ozone_box
#
#.Boxplot for wind values (round the wind to get a good number of "buckets")
#
wind_box<- ggplot(myAirquality, aes(x=factor(0),Wind)) +geom_boxplot() + ggtitle("Wind Box Plot")
wind_box
#
#Step 3: Explore how the data changes over time
#First, make sure to create appropriate dates (this data was from 1973). Then create line charts
#for ozone, temp, wind and solar.R(one line chart for each, and then one chart with 4 lines, 
#each having a different color). 
#
myAirquality$date<-as.Date(Numberize(c(paste(myAirquality$Month,"/",myAirquality$Day,"/", "73"))), format = "%m/%d/%y")
ozone_line<-ggplot(data=myAirquality,aes(x=date, y=Ozone)) + geom_line(color="blue") + ggtitle("Ozone Levels Line") + labs(x="Dates", y="Ozone Count")
solar_line<-ggplot(data=myAirquality,aes(x=date, y=Solar.R)) + geom_line(color="orange") + ggtitle("Solar Levels Line") + labs(x="Dates", y="Solar Count")
wind_line<-ggplot(data=myAirquality,aes(x=date, y=Wind)) + geom_line(color="green") + ggtitle("wind Levels Line") + labs(x="Dates", y="Wind Count")
temp_line<-ggplot(data=myAirquality,aes(x=date, y=Temp)) + geom_line(color="purple") + ggtitle("Temp Levels Line") + labs(x="Dates", y="Temp Count")
all_line<-ggplot(data=myAirquality, aes(date)) + geom_line(aes(y=Ozone),color="blue") + geom_line(aes(y=Solar.R),color="orange") + geom_line(aes(y=Wind),color="green") + geom_line(aes(y=Temp), color="purple")
ozone_line
solar_line
wind_line
temp_line
all_line
#
#Create these visualizations using ggplot.Note that for the chart with 4 lines, you need to think
#about how to effectively use the y-axis.
#
#Step 4: Look at all thedata via a Heatmap
#Create a heatmap, with each day along the x-axis and ozone, temp, wind and solar.r along the y-axis,
#and days as rows along the y-axis. Great the heatmap using geom_tile(this defines the ggplotgeometry
#to be 'tiles' as opposed to 'lines' and the other geometry we have previously used).
#Note that you need to figure out how to show the relative change equally across all the variables.
#

#
#Step 5: Look at all the data via a scatter chart
#Create a scatter chart(using ggplot geom_point), with the x-axis representing the wind, the y-axis 
#representing the temperature, the size of each dot representing the ozone and the color representing 
#the solar.
#

#
#RStep 6: Final Analysis
#.Do you see any patterns after exploring the data?
#
#
#.What was the most useful visualization?
#
#
#
#END OF SCRIPT