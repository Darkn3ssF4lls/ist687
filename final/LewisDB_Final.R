#### Generate a Function to Ensure a Package is Installed ###
EnsurePackage<-function(x){
  x<-as.character(x)
  if (!require(x,character.only=TRUE)){
    install.packages(pkgs=x, repos="http://cran.r-project.org")
    require(x, character.only=TRUE)
  }
}
###########Import All Required Packages#######################
EnsurePackage("compare")
EnsurePackage("ggplot2")
EnsurePackage("ggmap")
EnsurePackage("gridExtra")
EnsurePackage("maptools")
EnsurePackage("RJSONIO")

#############Import Source Data for Project###################
urlToImport <- "https://data.cityofnewyork.us/api/views/833y-fsy8/rows.csv?accessType=DOWNLOAD"
rawCSV <- data.frame((read.csv(urlToImport)))

########################Pre-Processing Steps##################

cleanCSV <- rawCSV
colnames(cleanCSV) <- tolower(colnames(cleanCSV))
cleanCSV$boro<-tolower(cleanCSV$boro)
cleanCSV$location_desc<-tolower(cleanCSV$location_desc)
cleanCSV$perp_sex<-tolower(cleanCSV$perp_sex)
cleanCSV$perp_race<-tolower(cleanCSV$perp_race)
cleanCSV$vic_sex<-tolower(cleanCSV$vic_sex)
cleanCSV$vic_race<-tolower(cleanCSV$vic_race)

########Create the Data Dictionary############################
varName<-c("list of names")
varType<-c("list of types")
varDesc<-c("list of descriptions")
dataDict<-data.frame(varName,varType,varDesc)
colnames(dataDict)<-c("Variable Name", "Variable Type", "Variable Description")

grid.table(dataDict)

########Create the map to plot on#############################


