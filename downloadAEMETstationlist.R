api="eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmYmFsYW9AdXMuZXMiLCJqdGkiOiIxYTM0NTQzMy1hNjQ2LTRhNzMtOTJiNy05N2UwMGY4NzI1YjMiLCJleHAiOjE0OTYzOTgwMjMsImlzcyI6IkFFTUVUIiwiaWF0IjoxNDg4NjIyMDIzLCJ1c2VySWQiOiIxYTM0NTQzMy1hNjQ2LTRhNzMtOTJiNy05N2UwMGY4NzI1YjMiLCJyb2xlIjoiIn0.ARJKETGf_pT_PKCPZjzWzsPDi1Rq37VNS2nRzo72jcc"

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
  q1 <- httr::GET(handle=urldatos, config=aut, path=paste("api/", resource[[5]], query, sep="") )
  dataQ1 <- httr::content(q1, type="application/json")
  df <- to_dataframe(dataQ1)
  return (df)
}
