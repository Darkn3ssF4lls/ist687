#### Generate a Function to Ensure a Package is Installed ###
EnsurePackage<-function(x){
  x<-as.character(x)
  if (!require(x,character.only=TRUE)){
    install.packages(pkgs=x, repos="http://cran.r-project.org")
    require(x, character.only=TRUE)
  }
}
removeTime <- function(inputVector){
  inputVector <-gsub(" 12:00:00 AM","",inputVector)
  inputVector <- gsub(" ", "", inputVector)
  inputVector <- as.Date(inputVector, format='%m/%d/%Y')
  return(inputVector)
}

###########Import All Required Packages#######################
EnsurePackage("compare")
EnsurePackage("ggplot2")
EnsurePackage("ggmap")
EnsurePackage("gridExtra")
EnsurePackage("rgeos")
EnsurePackage("maptools")
EnsurePackage("RJSONIO")
EnsurePackage("sqldf")

#############Import Source Data for Project###################
urlToImport <- "https://data.cityofnewyork.us/api/views/833y-fsy8/rows.csv?accessType=DOWNLOAD"
rawCSV <- data.frame((read.csv(urlToImport, stringsAsFactors = FALSE)))

########################Pre-Processing Steps##################
cleanCSV <- rawCSV
colnames(cleanCSV) <- tolower(colnames(cleanCSV))
cleanCSV$boro<-tolower(cleanCSV$boro)
cleanCSV$location_desc<-tolower(cleanCSV$location_desc)
cleanCSV$perp_sex<-tolower(cleanCSV$perp_sex)
cleanCSV$perp_race<-tolower(cleanCSV$perp_race)
cleanCSV$vic_sex<-tolower(cleanCSV$vic_sex)
cleanCSV$vic_race<-tolower(cleanCSV$vic_race)


cleanCSV$occur_date<-removeTime(cleanCSV$occur_date)

cleanCSV<-cleanCSV[,-7]
colnames(cleanCSV)

cleanCSV<-cleanCSV[complete.cases(cleanCSV),]

####################Creating Descriptive Statistics###########


#################Generating Graph Data########################

deaths <- sqldf("SELECT *
                FROM cleanCSV
                WHERE statistical_murder_flag IN ('true')")
injuries <- sqldf("SELECT *
                FROM cleanCSV
                  WHERE statistical_murder_flag NOT IN ('true')")
injuries<-injuries[,-8]
deaths<-deaths[,-8]

incidentsByLocation <- sqldf("SELECT DISTINCT incident_key, x_coord_cd, y_coord_cd, latitude, longitude
                             FROM cleanCSV")


########Create the Data Dictionary############################
varName<-colnames(cleanCSV)
varType<-c("int", "date", "chr", "chr", "int", "int", "chr", "chr", "chr", "chr", "chr", "chr", "chr", "int", "int", "num", "num")
varDesc<-c("Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me","Replace Me")
dataDict<-data.frame(varName,varType,varDesc)
colnames(dataDict)<-c("Variable Name", "Variable Type", "Variable Description")

grid.table(dataDict)

########Create the map to plot on#############################


