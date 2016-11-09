
## Open weather maps
# setwd("D:\\R Practice scripts\\OpenWeatherData")
weatherRepo <- readRDS("D:\\R_Practice_scripts\\OpenWeatherData\\WeatherRepo.rds")
library(rjson)
library(lubridate)
url <- "http://api.openweathermap.org/data/2.5/weather?lat=12.83606&lon=80.20362&appid=b1b15e88fa797225412429c1c50c122a"
json <- fromJSON(file = url)
t <- data.frame(cbind(
lon = json$coord[[1]],
lat = json$coord[[2]],
id = json$weather[[1]]$id[[1]],
main = json$weather[[1]]$main[[1]],
description = json$weather[[1]]$description[[1]],
icon = json$weather[[1]]$icon[[1]],
base = json$base[[1]],
temp = json$main[[1]],
pressure = json$main[[2]],
humidity = json$main[[3]],
temp_min = json$main[[4]],
temp_max = json$main[[5]],
# json$visibility,
wind_speed = json$wind[[1]],
wind_deg = json$wind[[2]],
clouds = json$clouds[[1]],
dt = json$dt[[1]],
sys_type = json$sys[[1]],
sys_id = json$sys[[2]],
sys_msg = json$sys[[3]],
sys_country = json$sys[[4]],
id1 = json$id[[1]],
name = json$name[[1]],
cod = json$cod[[1]],
sunrise = as.POSIXct(json$sys[[5]],origin = "1970-01-01", tz = ""),
sunset = as.POSIXct(json$sys[[6]],origin = "1970-01-01", tz = "")))
weatherRepo1 <- rbind(weatherRepo, t)
saveRDS(weatherRepo1, "D:\\R_Practice_scripts\\OpenWeatherData\\WeatherRepo.rds")
# Export
write.csv(weatherRepo1, "D:\\R_Practice_scripts\\OpenWeatherData\\OpenWeatherData.csv", row.names = FALSE)


