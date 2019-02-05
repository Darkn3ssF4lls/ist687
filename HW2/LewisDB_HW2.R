#############################################################################
#Name: Daniel Lewis
#Description: Homework Assignment 2
#Date: 01/24/2019 (JST)
#--------------HW2: Writing Functions -----------------
#Copy mtcars into myCars
myCars <- mtcars
#Step	1:	What	is	the	hp	(hp	stands	for	"horse	power")
#1) What	is	the	highest	hp?
index <-which.max(myCars$hp)
myCars$hp[index]
#2) Which	car	has	the	highest	hp?
rownames(myCars)[index]
#Step	2:	Explore	mpg	(mpg	stands	for	"miles	per	gallon")		
#3) What	is	the	highest	mpg?
index <-which.max(myCars$mpg)
myCars$mpg[index]
#4) Which	car	has	the	highest	mpg?
rownames(myCars)[index]
#5) Create	a	sorted	dataframe,	based	on	mpg
sortedMPG <- myCars[order(-myCars$mpg),]
sortedMPG

#Step	3:	Which	car	has	the	"best"	combination	of	mpg	and	hp?
#6) What logic	did	you	use?
#for this section I used a value derived by deviding the MPG by the ammount of HP.

#7) Which	car?
efficency <- data.frame(myCars, (myCars$mpg/myCars$hp))
colnames(efficency)[colnames(efficency)=="X.myCars.mpg.myCars.hp."] <- "eff"
efficency <- efficency[order(-efficency$eff),]
index <-which.max(efficency$eff)
rownames(efficency)[index]

#Step	4:	 Which	car	has "best"	car combination	of	mpg	and	hp,	where	mpg	and	hp	must	
#be	given	equal	weight?
#For this section we should use the scale function in r, than follow the efficency math from step3. 
efficency2 <- data.frame(scale(myCars))
efficency2 <- data.frame(efficency2, (efficency2$mpg/efficency2$hp))
colnames(efficency2)[colnames(efficency2)=="X.efficency2.mpg.efficency2.hp."] <- "eff"
efficency2 <- efficency2[order(-efficency2$eff),]
rownames(efficency2)[1]
