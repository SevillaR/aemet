
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
  urlbase <- httr::handle(urldatos)
  aut <- httr::authenticate(resource[[2]], resource[[3]])

  q1 <- httr::GET(handle=urldatos, config=aut, path=paste("api/", resource[[5]], query, sep="") )
  dataQ1 <- httr::content(q1, type="application/json")
  df <- to_dataframe(dataQ1)
  return (df)
}
