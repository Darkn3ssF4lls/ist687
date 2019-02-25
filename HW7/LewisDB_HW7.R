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
  return(as.numeric(inputVector))
}
#
#############################################################################
#############################IMPORTS SECTION#################################
#############################################################################
#Packages#
EnsurePackage("ggmap")
EnsurePackage("ggplot2")
EnsurePackage("sqldf")
EnsurePackage("reprex")
EnsurePackage("zipcode")
#DataSets#
###Works on my windows 10 and mac machines by hitting the source button#
###[sets working directory to the script folder]#
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
csv_import<-read.csv("MedianZIP-3.csv", stringsAsFactors = FALSE)
csv_backup<-read.csv("MedianZIP-3.csv", stringsAsFactors = FALSE)
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
#see imports section for loading package
#
colnames(csv_import)<-c('zip', 'median', 'mean', 'population')
csv_import$median<-Numberize(csv_import$median)
csv_import$mean<-Numberize(csv_import$mean)
csv_import$population<-Numberize(csv_import$population)
csv_import$zip<-paste(0,csv_import$zip)
csv_import$zip<-gsub(" ", "", csv_import$zip)
##4) Merge the zip code information from the two data frames (merge into one dataframe)
##5) Remove Hawaii and Alaska (just focus on the lower 48 states)
#
#gnerate zipcode and create backup#
data(zipcode)
zipcode_backup<-zipcode

#Code to select only the US minus HI,AK, and DC)#
#zipcode<- sqldf("SELECT * 
#      FROM zipcode 
#      WHERE state NOT IN ('AA','AE','AK','AP','AS','DC','FM','GU','HI','MH','MP','PR','PW','VI') " , row.names=TRUE)
zipcode<- sqldf("SELECT * 
      FROM zipcode 
      WHERE state IN ('AL','AZ','AR','CA','CO','CT','DE','FL','GA','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY') " , row.names=TRUE)
#
#Join the zipcode dataset with the csv dataset by matching zipcodes
zipcode_joincsv<-sqldf("select * 
                       from zipcode 
                       left join (select zip, median, mean, population from csv_import) using (zip)")

#sort the joined data by state abbrivations
zipcode_joincsv$state<-sort(zipcode_joincsv$state)
#generate a backup of joined data before cliping all rows with NA
join_backup<-zipcode_joincsv
#clip all rows with an NA field
zipcode_joincsv_nona<-zipcode_joincsv[complete.cases(zipcode_joincsv),]
#reset the row numering for easier access
rownames(zipcode_joincsv_nona)<-NULL
#
#Step 2: Show the income & population per state
##1) Create a simpler dataframe, with just the average median income and the the population for each state.
##2) Add the state abbreviations and the state names as new columns (make sure the state names are all lower case)#
#create a vector filled with the 50 states, than clip AK and HI
states<-tolower(state.name)
states<-states[-2]
states<-states[-10]
#generate a vector filled with the sates abreviations
abv<-tolower(c("AL","AZ","AR","CA","CO","CT","DE","FL","GA","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY"))
population<-NULL #generate code to add the populations of each state 
income<-NULL #generate the code to show the average income per state
step2_df<-data.frame(states, abv) #, population, median_income)
##3) Show the U.S. map, representing the color with the average median income of that state
#
us<-map_data("states")
income_map<-ggplot(data=step2_df, map_id=state)
income_map<-income_map + geom_map(map=us, aes(fill=income))
income_map<-income_map + expand_limits(x=us$long, y=us$lat)
income_map<-income_map + coord_map() + ggtile("State Colored by Median Income")
#
##4) Create a second map with color representing the population of the state
#
us<-map_data("states")
pop_map<-ggplot(data=step2_df, map_id=state)
pop_map<-pop_map + geom_map(map=us, aes(fill=income))
pop_map<-pop_map + expand_limits(x=us$long, y=us$lat)
pop_map<-pop_map + coord_map() + ggtile("State Colored by Population")
#
#Step 3: Show the income per zip code
##1) Have draw each zip code on the map, where the color of the ‘dot’ is based on the median income. To make the map look appealing, have the background of the map be black.
#

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