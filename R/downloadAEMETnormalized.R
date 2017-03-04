
#' Download normalized data from a list of AEMET stations
#'
#' @param api String with the AEMET API key (see https://opendata.aemet.es/)
#' @param station_id Vector with station_id (see downloadAEMETstationlist function)
#'
#' @return
#' @export
#'
#' @examples
downloadAEMETnormalized <- function(api,station_id){
  if(length(station_id) < 2){
    dat <- .downloadAEMETnormalized_one(api, station_id)
  } else{
    dat <- tryCatch({.downloadAEMETnormalized_one(api, station_id[1])})
    c=0
    for(i in 2:length(station_id)){
      c=c+1
      print(station_id[i])
      if( c %% 10 ==0 )   Sys.sleep(10)
      temp <- .downloadAEMETnormalized_one(api, station_id[i])
      dat <- rbind(dat, temp)
    }
  }
  dat
}

