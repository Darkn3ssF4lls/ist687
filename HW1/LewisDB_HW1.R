#############################################################################
#Name: Daniel Lewis
#Description: Homework Assignment 1
#Date: 01/17/2019 (JST)
#--------------HW1: Intro -----------------
#Define	the	following	vectors,	which	represent	the	weight	and	height	of	people	on	a	particular	team	(in	inches	and	pounds):
height <- c(59,60,61,58,67,72,70)
weight <- c(150,140,180,220,160,140,130)
#define a variable a
a <- c(150)
#------------------------------------------
#Step1: Calculate Mean
#Compute,	using	R,	the	average	height	(called	mean	in	R)
mean(height)
#Compute,	using	R,	the	average	weight	(called	mean	in	R)
mean(weight)
#Calculate	the	length	of	the	vector	'height'	and	'weight'
length(height)
length(weight)
#Calculate	the	sum	of	the	heights
sum(height)
#Compute	the	average of	both	height	and	weight,	by	dividing	the	sum (of	the	height	
#or	the	width,	as	appropriate),	by	the	length	of	the	vector.	How	does	this	compare	to	
#the	'mean'	function?
avgH <- sum(height)/length(height)
avgW <- sum(weight)/length(weight)
#this compares to the mean function in that it seems to give the same result except that the height is rounded in the mean function. 
#------------------------------------------
#Step2: Using max/min functions

#compute the max height, store the results in maxH
maxH <- max(height)

#computer the min weight, store the results in minW
minW <- min(weight)

#------------------------------------------
#Step 3: Vector Math
#create a new vector, which is the weight +5 (every person gained 5 pounds)
newWeight <- weight + 5

#compute the pounds/height for each person, using the new weight just created
height_to_newWeight <- data.frame(newWeight,height)

#------------------------------------------
#Step 4: Using Conditional if statements
#Write	the	R	code	to	test	if	max	height is	greater	than	60	(output	"yes"	or	"no")
if (maxH>60) "yes" else "no"
#)Write	the	R	code	to	if	min	weight is	greater	than	the	variable	'a'	(output	"yes"	or "no")
if (minW>a) "yes" else "no"
