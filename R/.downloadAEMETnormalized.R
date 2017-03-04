.downloadAEMETnormalized<-function (api, station_id)
{
  library(curl)
  library(httr)
  h = new_handle()
  handle_setheaders(h, `Cache-Control` = "no-cache", api_key = api)
  handle_setopt(h, ssl_verifypeer = FALSE)
  handle_setopt(h, customrequest = "GET")
  url <- paste("https://opendata.aemet.es/opendata/api/valores/climatologicos/normales/estacion/", paste(station_id, collapse = ","), sep = "")
  md_raw <- curl_fetch_memory(url, h)
  urldatos <- strsplit(rawToChar(md_raw$content), split = "\"")[[1]][10]

  url2 <- httr::handle(urldatos)
  set_config(config(ssl_verifypeer = 0L))
  q1 <- httr::GET(handle=url2)
  dataQ1 <- httr::content(q1, type="text/plain", encoding = "ISO-8859-15")
  library(RJSONIO)
  listQ1<-fromJSON(dataQ1)
  df <- t(sapply(listQ1,function(e) e))
  station_id=df[,"indicativo"]
 df2 = apply(df,2, as.character)
 df3= data.frame(apply(df2,2, as.numeric))
 df3$indicativo<-station_id
 colnames(df3)[1]<-"station_id"
return (df3)
}
