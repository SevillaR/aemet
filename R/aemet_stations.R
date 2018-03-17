#' Get AEMET stations
#'
#' @param apikey String with the AEMET API key (see https://opendata.aemet.es/).
#'
#' @return A data.frame
#' @export
#'
#' @examples \dontrun{
#' stations <- aemet_stations(apikey)
#' }
aemet_stations <- function(apikey) {

  stations <- get_data(apidest = "/api/valores/climatologicos/inventarioestaciones/todasestaciones", apikey)

  stations$longitud <- Vectorize(dms2decdegrees)(stations$longitud)
  stations$latitud <- Vectorize(dms2decdegrees)(stations$latitud)

  df <- stations[, c("indicativo", "indsinop", "nombre", "provincia", "altitud",
                     "longitud", "latitud")]

  df

}
