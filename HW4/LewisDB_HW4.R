#############################################################################
#Name: Daniel Lewis
#Description: Homework Assignment 4
#Date: 2/1/19 (JST)
#input: CSV file from the U.S. Census 
#output:
#update history:
#############################################################################
###############################HW4 Samples	HW###############################
#############################################################################
#
#############################################################################
################################IMPORTS SECTION##############################
#############################################################################
#
install.packages("moments")
library("moments")
#
#############################################################################
############################LOCAL FUNCTIONS##################################
#############################################################################
#
#No local functions in this project. 
#
#Step 1: Write a summarizing function to understand the distribution of a vector
  #1. The function, call it 'printVecInfo' should take a vector as input
  #2. The function should print the following information:
    #a. Mean
    #b. Median
    #c. Min & max
    #d. Standard deviation
    #e. Quantiles (at 0.05 and 0.95)
    #f. Skewness
#Note for skewness, you can use the function in the 'moments' library.
#
printVecInfo <- function(vector){
  cat("Mean:", mean(vector),
      "Median:",median(vector),
      "Min:",min(vector),
      "Max:",max(vector),
      "sd:", sd(vector),
      "quantile (0.05 - 0.95:)",quantile(vector, probs = c(.05, .95)),
      "skewness:", skewness(vector),sep="\n")
}
#  
  #3. Test the function with a vector that has (1,2,3,4,5,6,7,8,9,10,50). You should see 
  #something such as:
    #[1] "mean: 9.54545454545454"
    #[1] "median: 6"
    #[1] "min: 1  max: 50"
    #[1] "sd: 13.7212509368762"
    #[1] "quantile (0.05 - 0.95): 1.5 -- 30"
    #[1] "skewness: 2.62039633563579"
#
given.sample <- c(1,2,3,4,5,6,7,8,9,10,50)
printVecInfo(given.sample)
#
#Step 2: Creating Samples in a Jar
  #4. Create a variable 'jar' that has 50 red and 50 blue marbles (hint: the jar can have strings as objects, with some of the strings being 'red' and some of the strings being 'blue')
red <- rep("red",50)
blue <- rep("blue",50)
  #5. Confirm there are 50 reds by summing the samples that are red
count.red <- length(grep("red", jar, ignore.case = FALSE, perl = FALSE, value = FALSE, fixed = FALSE, useBytes = FALSE, invert = FALSE))
  #6. Sample 10 'marbles' (really strings) from the jar. How many are red? What was the percentage of red marbles?
sample10 <- sample(jar, size=10, replace=TRUE)
count.red1 <- length(grep("red", sample1, ignore.case = FALSE, perl = FALSE, value = FALSE, fixed = FALSE, useBytes = FALSE, invert = FALSE))
percent <- c((count.red1/length(sample1))*100,"%")
cat("Percentage of Red Marbales:")
  #7. Do the sampling 20 times, using the 'replicate' command. This should generate a list of 20 numbers. Each number is the mean of how many reds there were in 10 samples. Use your printVecInfo to see information of the samples. Also generate a histogram of the samples.
sample20 <- replicate(20, mean(),ignore.case = FALSE, perl = FALSE, value = FALSE, fixed = FALSE, useBytes = FALSE, invert = FALSE))
  #8. Repeat #7, but this time, sample the jar 100 times. You should get 20 numbers, this time each number represents the mean of how many reds there were in the 100samples. Use your printVecInfo to see information of the samples. Also generate a histogram of the samples.
  
  #9. Repeat #8, but this time, replicate the sampling 100 times. You should get 100 numbers, this time each number represents the mean of how many reds there were in the 100 samples. Use your printVecInfo to see information of the samples. Also generate a histogram of the samples.
#
jar <- c(red,blue)
sum(count.red)
#
#Step 3: Explore the airquality dataset
  #10. Store the 'airquality' dataset into a temporary variable
  #11. Clean the dataset (i.e. remove the NAs)
  #12. Explore Ozone, Wind and Temp by doing a 'printVecInfo' on each as well as 
  #generating a histogram for each
#
my.airquality <- airquality[complete.cases(airquality),]
row.names(my.airquality) <- NULL
my.airquality
printVecInfo(my.airquality$Ozone)
hist(my.airquality$Ozone, main="New York Ozone May-Sep 1973", xlab="Ozone in ppb", col="blue")
printVecInfo(my.airquality$Wind)
hist(my.airquality$Wind, main="New York Wind May-Sep 1973", xlab="Wind in MPH", col="orange")
printVecInfo(my.airquality$Temp)
hist(my.airquality$Temp,main="New York Temperature May-Sep 1973", xlab="Degrees F", col="red")
#
#END OF SCRIPT