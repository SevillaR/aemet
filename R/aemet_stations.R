#' Get AEMET stations
#'
#' @param apikey String with the AEMET API key (see https://opendata.aemet.es/).
#'
#' @return A SpatialPointsDataFrame.
#' @export
#'
#' @import curl
#' @import httr
#' @import sp
#' @import RJSONIO
#'
#' @examples \dontrun{
#' stations <- aemet_stations(apikey)  #SpatialPointsDataFrame
#' stationdata <- as.data.frame(stations)
#' }
aemet_stations <- function(apikey) {

  df <- data.frame(t(sapply(listQ1, function(e) e)))
  station_id <- df[, "indicativo"]
  longString <- as.character(df[, "longitud"])
  latString <- as.character(df[, "latitud"])


  deg <- as.numeric(substr(longString, 0, 2))
  min <- as.numeric(substr(longString, 3,4))
  sec <- as.numeric(substr(longString, 5,6))
  x <- deg + min/60 + sec/3600
  x <- ifelse(substr(longString, 7, 8) == "W", x, -x)
  deg <- as.numeric(substr(latString, 0, 2))
  min <- as.numeric(substr(latString, 3,4))
  sec <- as.numeric(substr(latString, 5,6))
  y <- deg + min/60 + sec/3600
  points <- SpatialPoints(coords = cbind(-x, y), CRS("+proj=longlat"))
  colnames(points@coords) <- c("longitude", "latitude")
  dfout <- data.frame(station_id = df[, "indicativo"],
                      station = df[, "nombre"],
                      province = df[, "provincia"],
                      elevation = as.numeric(df[, "altitud"]))

  finaldf <- SpatialPointsDataFrame(points, dfout)

  return(finaldf)

}
