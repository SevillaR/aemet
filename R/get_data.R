#' Get data from AEMET
#'
#' @param apidest character Destination URL. See \url{https://opendata.aemet.es/dist/index.html#!/valores-climatologicos/Inventario_de_estaciones_valores_climatol%C3%B3gicos}.
#' @param apikey Personal API key (see \url{https://opendata.aemet.es/centrodedescargas/inicio}).
#'
#' @return a data.frame
#' @export
#' @import httr
#' @importFrom jsonlite fromJSON
#'
#'
get_data <- function(apidest, apikey) {

  url1 <- paste0(url.base, apidest)

  path1 <- httr::GET(url1, add_headers(api_key = apikey))

  url.data <- httr::content(path1, as = "parsed")$datos
  url.metadata <- httr::content(path1, as = "parsed")$metadatos

  #path2 <- GET(url.data, add_headers(api_key = apikey)) # it seems apikey not necessary for this step
  path2 <- httr::GET(url.data)
  data.json <- httr::content(path2, as = "text")
  datos <- jsonlite::fromJSON(data.json)

  datos

}