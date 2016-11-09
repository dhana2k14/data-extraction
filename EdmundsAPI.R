
## Edmunds Vehicle API

install.packages("RJSONIO")
library(RJSONIO)

APIKey = 'bh5n4r5yxvkqycjh4vr4jsg4'
resURL <- paste("https://api.edmunds.com/v1/api/maintenance/actionrepository/findbymodelyearid?modelyearid=100537293&fmt=json&api_key=",
                APIKey, sep = "")
makesJSON <- fromJSON(resURL)

## Vehicle Maintenance API

vehicleMaintenanceData <- data.frame(NULL)
for (i in c(2000:2015))
{
  url <- paste("https://api.edmunds.com/v1/api/maintenance/actionrepository/findbymodelyearid?modelyearid=",i,"&fmt=json&api_key=",APIKey,sep = "")
  jsonData <- fromJSON(url)
  
  id <- sapply(jsonData$actionHolder, function(x) x$id)
  engineCode <- sapply(jsonData$actionHolder, function(x) x$engineCode)
  transmissionCode <- sapply(jsonData$actionHolder, function(x) x$transmissionCode)
  intervalMileage <- sapply(jsonData$actionHolder, function(x) x$intervalMileage)
  intervalMonth <- sapply(jsonData$actionHolder, function(x) x$intervalMonth)
  frequency <- sapply(jsonData$actionHolder, function(x) x$frequency)
  action <- sapply(jsonData$actionHolder, function(x) x$action)
  item <- sapply(jsonData$actionHolder, function(x) x$item)
  itemDescription <- sapply(jsonData$actionHolder, function(x) x$itemDescription)
  laborUnits <- sapply(jsonData$actionHolder, function(x) x$laborUnits)
  partUnits <- sapply(jsonData$actionHolder, function(x) x$partUnits)
  driveType <- sapply(jsonData$actionHolder, function(x) x$driveType)
  modelYear <- sapply(jsonData$actionHolder, function(x) x$modelYear)
  
  data <- data.frame(id, 
                              engineCode,
                              transmissionCode,
                              intervalMileage,
                              # unlist(intervalMonth),
                              frequency,
                              action,
                              item,
                              itemDescription,
                              laborUnits,
                              partUnits,
                              driveType,
                              modelYear = substr(modelYear,regexpr('=',modelYear)[1]+1, nchar(modelYear)))
  
  vehicleMaintenanceData = rbind(vehicleMaintenanceData, data)
  
  }

# Vehicle Servive bulletin

vehicleServiceData <- data.frame(NULL)

for (i in c(2000:2015))
{
      url <- paste("https://api.edmunds.com/v1/api/maintenance/servicebulletinrepository/findbymodelyearid?modelyearid=",i,"&fmt=json&api_key=",APIKey,sep="")
      jsonData <- fromJSON(url)

      id <- sapply(jsonData$serviceBulletinHolder, function(x) x$id)
      bulletinNumber <- sapply(jsonData$serviceBulletinHolder, function(x) x$bulletinNumber)
      bulletinDateMonth <- sapply(jsonData$serviceBulletinHolder, function(x) x$bulletinDateMonth)
      bulletinDate <- sapply(jsonData$serviceBulletinHolder, function(x) x$bulletinDate)
      componentNumber <- sapply(jsonData$serviceBulletinHolder, function(x) x$componentNumber)
      componentDescription <- sapply(jsonData$serviceBulletinHolder, function(x) x$componentDescription)
      nhtsaItemNumber <- sapply(jsonData$serviceBulletinHolder, function(x) x$nhtsaItemNumber)
      modelYearId <- sapply(jsonData$serviceBulletinHolder, function(x) x$modelYearId)
      summaryText <- sapply(jsonData$serviceBulletinHolder, function(x) x$summaryText)
      
      data <- data.frame(id, bulletinNumber,bulletinDateMonth,bulletinDate,componentNumber,
                         componentDescription,nhtsaItemNumber,modelYearId,summaryText)
      vehicleServiceData <- rbind(vehicleServiceData, data)

}

# Vehicle Transmission details

# vehicleTransmissionData <- data.frame(NULL)
# 
# for (i in c(2000:2015))
# {
#   
#   url <- paste("https://api.edmunds.com/api/vehicle/v2/transmissions/{id}?fmt=json&api_key={api key}))
# }

# active cars from 2000 to 2015

vehicleMakes <- data.frame(NULL)

for (i in c(2000:2015))
{
    
  url <- paste("http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&year=",i,"&api_key=",APIKey,sep="")
  jsonData <- fromJSON(url)
  
  vehicleMakeId <- sapply(jsonData$makes, function(x) rep(x$id, length(x$models)))
  makeName <- sapply(jsonData$makes, function(x) rep(x$niceName, length(x$models)))
  # makeModelName <- sapply(jsonData$makes, function(x) sapply(x$models, function(y) y$id))
  modelName <- sapply(jsonData$makes, function(x) sapply(x$models, function(y) y$niceName))
  modelId <- sapply(jsonData$makes, function(x) sapply(x$models, function(y) y$years[[1]][1]))
  yearId <- sapply(jsonData$makes, function(x) sapply(x$models, function(y) y$years[[1]][2]))
  

  data <- data.frame(vehicleMakeId = unlist(vehicleMakeId), 
                     makeName = unlist(makeName), 
                     modelName = unlist(modelName), 
                     modelId = unlist(modelId), 
                     yearId = unlist(yearId))
  vehicleMakes <- rbind(vehicleMakes, data)

}

vehicleStyle <- data.frame(NULL)

# for (i in seq(1:5))
# {
#       url <- paste("https://api.edmunds.com/api/vehicle/v2/",vehicleMakes$makeName[i],"/",vehicleMakes$modelName[i],"/",vehicleMakes$yearId[i],"/styles?fmt=json&api_key=",APIKey, sep = "")
#       jsonData <- fromJSON(url)
# }


url <- paste("https://api.edmunds.com/api/vehicle/v2/audi/a4/2015/styles?state=used&view=full&fmt=json&api_key=",APIKey, sep = "")
jsonData <- fromJSON(url)

make <- sapply(jsonData$styles, function(x) x$make)
model <- sapply(jsonData$styles, function(x) x$model)
engine <- sapply(jsonData$styles, function(x) x$engine)
transmission <- sapply(jsonData$styles, function(x) x$transmission)
options <- sapply(jsonData$styles, function(x) x$options)


id <- sapply(jsonData$styles, function(x) x$id)
name <- sapply(jsonData$styles, function(x) x$name)
year <- sapply(jsonData$styles, function(x) x$year)
submodel <- sapply(jsonData$styles, function(x) x$submodel)
trim <- sapply(jsonData$styles, function(x) x$trim)
states <- sapply(jsonData$styles, function(x) x$states)
squishVins <- sapply(jsonData$styles, function(x) x$squishVins)
categories <- sapply(jsonData$styles, function(x) x$categories)
mpg <- sapply(jsonData$styles, function(x) x$MPG)

manfCode <- sapply(jsonData$styles, function(x) x$manufacturerCode)
manfOptName <- sapply(jsonData$styes, function(x) x$manufactureOptionName)

color <- sapply(jsonData$styles, function(x) sapply(x$colors, function(y) y$options))


## To extrct Style ID

styleData <- data.frame(NULL)

for (i in seq(1:nrow(vehicleMakes)))
{
  
url <- paste("https://api.edmunds.com/api/vehicle/v2/",vehicleMakes$makeName[5050],"/",vehicleMakes$modelName[i],"?fmt=json&state=new&api_key=",APIKey, sep = '')
jsonData <- fromJSON(url)

if (length(jsonData$years) != 0) 
{

for (j in seq(1:length(jsonData$years)))
{
  makeId <- data.frame(makeId = rep(jsonData$id, length(jsonData$years[[j]]$styles)))
  niceName <- data.frame(niceName = rep(jsonData$niceName, length(jsonData$years[[j]]$styles)))
  yearId <- data.frame(yearId = rep(jsonData$years[[j]]$id, length(jsonData$years[[j]]$styles)))
  year <- data.frame(year = rep(jsonData$years[[j]]$year, length(jsonData$years[[j]]$styles)))
  styleId <- data.frame(styleId = t(t(sapply(jsonData$years[[j]]$styles, function(x) x$id))))
  styleName <- data.frame(styleName = t(t(sapply(jsonData$years[[j]]$styles, function(x) x$name))))
  # submodelName <- sapply(jsonData$years[[j]]$styles, function(x) x$submodel[3])
  trim <- data.frame(trim = t(t(sapply(jsonData$years[[j]]$styles, function(x) x$trim))))
  Data <- cbind(makeId, niceName, yearId, year, styleId, styleName, trim)
  styleData <- rbind(styleData, Data)
}
}
else
{
  next
}
}
































