#############################################################################
#Name: Daniel Lewis
#Description: Homework Assignment 5
#Date: 2/8/19 (JST)
#input: 
#output: 
#update history:
#############################################################################
###############HW5 JSON & tapply Homework: Accident Analysis#################
#############################################################################
#
#
#############################################################################
#############################IMPORTS SECTION#################################
#############################################################################
#
#
#############################################################################
############################LOCAL FUNCTIONS##################################
#############################################################################
#
#Step 1: Load the data
#
#   Read in the following JSON dataset http://data.maryland.gov/api/views/pdvh-tf2u/rows.json?accessType=DOWNLOAD
#
#Step 2: Clean the data
#
#   After you load the data, remove the first 8 columns, and then, to make it easier to work with, name the rest of the columns as follows:
#
#Note, not surprisingly, it is in JSON format.  You should be able to see that the first result is the metadata (information about the data) and the second is the actual data.
#namesOfColumns <- c("CASE_NUMBER","BARRACK","ACC_DATE","ACC_TIME","ACC_TIME_CODE","DAY_OF_WEEK","ROAD","INTERSECT_ROAD","DIST_FROM_INTERSECT","DIST_DIRECTION","CITY_NAME","COUNTY_CODE","COUNTY_NAME","VEHICLE_COUNT","PROP_DEST","INJURY","COLLISION_WITH_1","COLLISION_WITH_2")
#
#Step 3: Understand the data using SQL (via SQLDF)
#
#Answer the following questions:
#1) How many accidents happen on SUNDAY  
#
#2) How many accidents had injuries (might need to remove NAs from the data)
#
#3) List the injuries by day
#
#Step 4: Understand the data using tapply
#
#Answer the following questions (same as before) - compare results:
#1) How many accidents happen on Sunday
#
#2) How many accidents had injuries (might need to remove NAs from the data)
#
#3) List the injuries by day
#
#
#END OF SCRIPT