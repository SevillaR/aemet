
#' Download normalized data from a list of AEMET stations
#'
#' @param apikey String with the AEMET API key (see https://opendata.aemet.es/).
#' @param station_id Vector with station_id (see \code{\link{aemet_stations}}).
#'
#' @return A data frame.
#' @export
#'
#' @import curl
#' @import httr
#' @import RJSONIO
#'
#' @examples \dontrun{
#' grazalema <- get_aemet_normalized(apikey, "5911A")
#' }
#'
get_aemet_normalized <- function(apikey, station_id) {

  if (length(station_id) < 2) {
    dat <- .download_aemet_normalized(apikey, station_id)
  } else{
    dat <- tryCatch({.download_aemet_normalized(apikey, station_id[1])})
    c <- 0
    for (i in 2:length(station_id)) {
      c <- c+1
      print(station_id[i])
      if (c %% 10 == 0) Sys.sleep(10)
      temp <- .download_aemet_normalized(apikey, station_id[i])
      dat <- rbind(dat, temp)
    }
  }
  dat
}






.download_aemet_normalized <- function(apikey, station_id) {

  h = new_handle()
  handle_setheaders(h, `Cache-Control` = "no-cache", api_key = apikey)
  handle_setopt(h, ssl_verifypeer = FALSE)
  handle_setopt(h, customrequest = "GET")
  url <- paste("https://opendata.aemet.es/opendata/api/valores/climatologicos/normales/estacion/", paste(station_id, collapse = ","), sep = "")
  md_raw <- curl_fetch_memory(url, h)
  urldatos <- strsplit(rawToChar(md_raw$content), split = "\"")[[1]][10]

  url2 <- httr::handle(urldatos)
  set_config(config(ssl_verifypeer = 0L))
  q1 <- httr::GET(handle = url2)
  dataQ1 <- httr::content(q1, type = "text/plain", encoding = "ISO-8859-15")
  listQ1 <- fromJSON(dataQ1)
  df <- t(sapply(listQ1, function(e) e))
  station_id <- df[, "indicativo"]
  df2 <- apply(df, 2, as.character)
  df3 <- data.frame(apply(df2, 2, as.numeric))
  df3$indicativo <- station_id
  colnames(df3)[1] <- "station_id"
  return(df3)
}
