#' Get data from AEMET
#'
#' @param apidest character Destination URL. See \url{https://opendata.aemet.es/dist/index.html}.
#' @param apikey Personal API key (see \url{https://opendata.aemet.es/centrodedescargas/inicio}).
#'
#' @return a data.frame
#' @export
#' @import httr
#' @importFrom jsonlite fromJSON
#' @importFrom stringr str_extract_all
#'
#'
get_data <- function(apidest, apikey) {

  url.base <- "https://opendata.aemet.es/opendata"

  url1 <- paste0(url.base, apidest)

  path1 <- httr::GET(url1, add_headers(api_key = apikey))

  urls.text <- httr::content(path1, as = "text")

  ## TO DO: use base R rather than stringr
  ## Also extract urls more safely
  urls <- unlist(strsplit(urls.text, "\\\""))
  urls <- urls[grep("https://opendata.aemet.es/opendata/sh/", urls)]
  url.data <- urls[1]
  url.metadata <- urls[2]

  #path2 <- GET(url.data, add_headers(api_key = apikey)) # it seems apikey not necessary for this step
  path2 <- httr::GET(url.data)
  data.json <- httr::content(path2, as = "text")
  datos <- jsonlite::fromJSON(data.json)

  datos

}
