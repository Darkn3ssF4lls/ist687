##################Common Functions##########################
#
#Downloads and Activates R Packadges
EnsurePackage<-function(x){
  x<-as.character(x)
  if (!require(x,character.only=TRUE)){
    install.packages(pkgs=x, repos="http://cran.r-project.org")
    require(x, character.only=TRUE)
  }
}
#
#Removes Commas and White Space from Strings returns a Int
Numberize <- function(inputVector)
{
  inputVector <- gsub(",", "", inputVector)
  inputVector <- gsub(" ", "", inputVector)
  return(inputVector)
}
###############Functions for Chapter 7#######################
#
#Reads US Census returns cleaned data frame 
readCensus<-function(){
  urlToRead<-"http://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv"
  tempFrame<-data.frame(read.csv(urlToRead))
  tempFrame<-tempFrame[-1:-8,1:5]
  tempFrame<-tempFrame[-52:-58,]
  colnames(tempFrame)<-c("stateName", "april10census","april10base", "july10pop", "july11pop")
  row.names(tempFrame)<- NULL
  tempFrame$statename<-gsub("\\.","",tempFrame$statename)
  tempFrame$base2010<-Numberize(tempFrame$base2010)
  tempFrame$base2011<-Numberize(tempFrame$base2011)
  tempFrame$july2010<-Numberize(tempFrame$july2010)
  tempFrame$july2011<-Numberize(tempFrame$july2011)
  return(tempFrame)
}
#
#takes an string based address and returns a lat and long
geocode<-function(address){
  root<-"http://maps.google.com/maps/api/geocode"
  google.url<-paste(root,"json?address=",address,"&sensor=false",sep="")
  url<-URLencode(google.url)
  apiResult<-getURL(url)
  geoStruct<- fromJSON(apiResult, simplify=FALSE)
  lat<-NA
  lng<-NA
  try(lat<-geoStruct$results[[1]]$geometry$location$lat)
  try(lng<-geoStruct$results[[1]]$geometry$location$lng)
  return(c(lat,lng))
}
EnsurePackage("ggplot2")
EnsurePackage("mapproj")
EnsurePackage("RJSONIO")
EnsurePackage("RCurl")
#-------------------------------#
#End Local Functions and Imports#
#-------------------------------#

#creates a dataframe from default dataset state, saved as strings
dummyDF <- data.frame(state.name, stringsAsFactors=FALSE)
#turns these values into all lowercase
dummyDF$state<-tolower(dummyDF$state)


#creates mapdata for US called state
us<-map_data("state")

#creates a simple ggplot map based of of the states with map id state
map.simple<-ggplot(dummyDF, aes(map_id = state))
#defines the map graphic as the states, fills it white and borders states with black
map.simple<- map.simple + geom_map(map = us, fill="white", color="black")
#deploys the map with us based lat and long values
map.simple<- map.simple + expand_limits(x=us$long, y=us$lat) 
#constrains the praportions of the map and adds a title
map.simple<- map.simple + ggtitle("basic map of USA") + coord_map() 
#print the map
map.simple

#--------------------
#Adding Points-------
#--------------------

map.simple+geom_point(aes(x=-100, y=30))


#--------------------
#Creating Pop Maps---
#--------------------

#create a dataframe filled with census data
dfStates <- readCensus()
#this does not work as presented
dfStates$statename<-tolower(dfStates$statename) #dr saltz has dfStates#state<-tolower(dfStates$region)

#create a ggplot map
map.popColor<-ggplot(dfStates,aes(map_id=statename)) #dr saltz has map_id=state
#fill by july11pop data
map.popColor<-map.popColor + geom_map(map=us, aes(fill=july11pop))
#grow map to the US lat long
map.popColor<-map.popColor + expand_limits(x=us$long, y=us$lat)
#constrain map to the US shape and title it STate Population
map.popColor<-map.popColor+coord_map()+ggtitle("state population")
map.popColor

latlon<-geocode("syracuse university, syracuse, ny")
