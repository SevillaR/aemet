
downloadAEMETstationlist<-function (api)
  {
  library(curl)
  library(httr)
  h = new_handle()
  handle_setheaders(h, `Cache-Control` = "no-cache", api_key = api)
  handle_setopt(h, ssl_verifypeer = FALSE)
  handle_setopt(h, customrequest = "GET")
  url <- paste("https://opendata.aemet.es/opendata/api/valores/climatologicos/inventarioestaciones/todasestaciones/")
  md_raw <- curl_fetch_memory(url, h)
  urldatos <- strsplit(rawToChar(md_raw$content), split = "\"")[[1]][10]

  url2 <- httr::handle(urldatos)
  set_config(config(ssl_verifypeer = 0L))
  q1 <- httr::GET(handle=url2)
  dataQ1 <- httr::content(q1, type="text/plain", encoding = "ISO-8859-15")
  library(RJSONIO)
  listQ1<-fromJSON(dataQ1)
  df <- data.frame(t(sapply(listQ1,function(e) e)))
  station_id = df[, "indicativo"]
  longString = as.character(df[, "longitud"])
  latString = as.character(df[, "latitud"])


  deg = as.numeric(substr(longString, 0, 2))
  min = as.numeric(substr(longString, 3,4))
  sec = as.numeric(substr(longString, 5,6))
  x = deg + min/60 + sec/3600
  x<-ifelse(substr(longString, 7, 8) =="W", x, -x)
  deg = as.numeric(substr(latString, 0, 2))
  min = as.numeric(substr(latString, 3,4))
  sec = as.numeric(substr(latString, 5,6))
  y = deg + min/60 + sec/3600
  points <- SpatialPoints(coords = cbind(-x, y), CRS("+proj=longlat"))
  colnames(points@coords) <- c("longitude", "latitude")
  dfout <- data.frame(station_id=df[,"indicativo"], station = df[, "nombre"], province = df[, "provincia"], elevation = as.numeric(df[, "altitud"]))

  finaldf<-SpatialPointsDataFrame(points, dfout)

  return (finaldf)
}
