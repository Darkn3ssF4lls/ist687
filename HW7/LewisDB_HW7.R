#############################################################################
#Name: Daniel Lewis
#Description: Homework Assignment 7
#Date: 2/25/19 (JST)
#input: MedianZIP-3.csv
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
dedot <- function(inputVector){
  inputVector <- gsub("\\.","",csv_import)
}
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
EnsurePackage("compare")
EnsurePackage("ggmap")
EnsurePackage("ggplot2")
EnsurePackage("mapproj")
EnsurePackage("sqldf")
EnsurePackage("stringr")
EnsurePackage("reprex")
EnsurePackage("zipcode")
#DataSets#
###Works on my windows 10 and mac machines by hitting the source button#
###[sets working directory to the script folder]#
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
#csv_import<-read.csv("MedianZIP-3.csv", stringsAsFactors = FALSE)
csv_import<-read.csv("Median-Cleaned.csv", stringsAsFactors = FALSE)
#
#############################################################################
#############################Problems Solved#################################
#############################################################################
#
#Step 1: Load the Data
##1) Read the data using the gdata package we have previously used.
##2) Clean up the dataframe
###a. Remove any info at the front of the file that not needed
###b. Update the column names (zip, median, mean, population)
##3) Load the "zipcode" package
##4) Merge the zip code information from the two data frames (merge into one dataframe)
##5) Remove Hawaii and Alaska (just focus on the lower 48 states)
#############################################################################

#turn the col names to lowercase#
colnames(csv_import)<-tolower(colnames(csv_import))

#clean up the data frame#

csv_import<-data.frame(sapply(csv_import, Numberize))

#fix the zip column length#
csv_import$zip<-str_pad(csv_import$zip, 5, "left","0")

#generate zipcode data frame#
data(zipcode)

#perform a merge based on zipcode col#
zipcode_joincsv<-merge(x=zipcode, y=csv_import, by="zip")

#sort by abv
colnames(zipcode_joincsv)[3]<-"abv"
zipcode_joincsv$abv<-sort(zipcode_joincsv$abv)

#Restrict to Lower 48 States (excluding all US territories)#
zipcode_joincsv<-data.frame(sqldf("SELECT *
                                  FROM zipcode_joincsv
                                  WHERE abv NOT IN ('AK', 'HI', 'DC')", row.names=TRUE))

#
#Step 2: Show the income & population per state
##1) Create a simpler dataframe, with just the average median income and the the population for each state.
##2) Add the state abbreviations and the state names as new columns (make sure the state names are all lower case)#
#create a vector filled with the 50 states, than clip AK and HI
states<-tolower(state.name)
states<-states[-2]
states<-states[-10]
#generate a vector filled with the sates abreviations
abv<-state.abb
abv<-abv[-2]
abv<-abv[-10]
#places state and abv into a data frame#
step2_df<-data.frame(states, abv)
#sums the population by states and puts them in the data frame#
population<-sqldf("SELECT sum(pop) AS 'pop'
                  FROM zipcode_joincsv 
                  GROUP BY abv")
#generates the medium income by state and stores it into a vector#
income<-sqldf("SELECT AVG(median) AS 'income'
                  FROM zipcode_joincsv 
                          GROUP BY abv")
#reformat data frame with all fields#
step2_df<-data.frame(states,abv,population,income)
##3) Show the U.S. map, representing the color with the average median income of that state
#
us<-map_data("state")
map.incomeColor<-ggplot(step2_df,aes(map_id=states))
map.incomeColor<-map.incomeColor+ geom_map(map=us, aes(fill=income))
map.incomeColor<-map.incomeColor+expand_limits(x=us$long, y=us$lat)
map.incomeColor<-map.incomeColor+coord_map()+ggtitle("States by Average Median Income")
map.incomeColor
##4) Create a second map with color representing the population of the state
#
us<-map_data("state")
map.popColor<-ggplot(step2_df,aes(map_id=states))
map.popColor<-map.popColor+ geom_map(map=us, aes(fill=pop))
map.popColor<-map.popColor+expand_limits(x=us$long, y=us$lat)
map.popColor<-map.popColor+coord_map()+ggtitle("States by Population")
map.popColor
#
#Step 3: Show the income per zip code
##1) Have draw each zip code on the map, where the color of the dota is based on the median income. To make the map look appealing, have the background of the map be black.
#
us<-map_data("state")
map.popColor<-ggplot(step2_d,aes(map_id=states))
map.popColor<-map.popColor+ geom_map(map=us, aes(fill=pop))
map.popColor<-map.popColor+expand_limits(x=us$long, y=us$lat)
map.popColor<-map.popColor+coord_map()+ggtitle("States by Population")
map.popColor
#
#Step 4: Show Zip Code Density
##1) Now generate a different map, one where we can easily see where there are lots of zip codes, and where there are few (using the ‘stat_density2d’ function).
#

#
#Step 5: Zoom in to the region around NYC
##1) Repeat steps 3 & 4, but have the image / map be of the northeast U.S. (centered around New York).
#

#
#END OF SCRIPT