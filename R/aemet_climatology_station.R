#' Get normal climatology values for a station
#'
#' Standard climatology from 1981 to 2010.
#'
#' @param station Station identifier code (see \code{\link{aemet_stations}}).
#' @param apikey Personal API key (see \url{https://opendata.aemet.es/centrodedescargas/inicio}).
#'
#' @return a data.frame
#' @export
#'
#' @examples \dontrun{
#' aemet_climatology_station("5911A")
#' }
aemet_climatology_station <- function(station, apikey) {

  apidest <- paste0("/api/valores/climatologicos/normales/estacion/", station)

  clim <- get_data(apidest, apikey)

}