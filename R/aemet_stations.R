#' Get AEMET stations
#'
#' @param apikey String with the AEMET API key (see https://opendata.aemet.es/).
#'
#' @return A SpatialPointsDataFrame.
#' @export
#'
#' @import httr

#'
#' @examples \dontrun{
#' stations <- aemet_stations(apikey)  #SpatialPointsDataFrame
#' stationdata <- as.data.frame(stations)
#' }
aemet_stations <- function(apikey) {

  stations <- get_data(apidest = "/api/valores/climatologicos/inventarioestaciones/todasestaciones", apikey)

  stations$longitud <- Vectorize(dms2decdegrees)(stations$longitud)


  df <- data.frame(t(sapply(listQ1, function(e) e)))
  station_id <- df[, "indicativo"]
  longString <- as.character(df[, "longitud"])
  latString <- as.character(df[, "latitud"])

  x <-
  points <- SpatialPoints(coords = cbind(-x, y), CRS("+proj=longlat"))
  colnames(points@coords) <- c("longitude", "latitude")
  dfout <- data.frame(station_id = df[, "indicativo"],
                      station = df[, "nombre"],
                      province = df[, "provincia"],
                      elevation = as.numeric(df[, "altitud"]))

  finaldf <- SpatialPointsDataFrame(points, dfout)

  return(finaldf)

}
