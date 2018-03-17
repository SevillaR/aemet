#' Converts degrees, minutes and seconds to decimal degrees
#'
#' @param input character
#'
#' @return num
#' @export
#'
#' @examples
#' dms2decdegrees("055245W")
#'
dms2decdegrees <- function(input) {
  deg <- as.numeric(substr(input, 0, 2))
  min <- as.numeric(substr(input, 3,4))
  sec <- as.numeric(substr(input, 5,6))
  x <- deg + min/60 + sec/3600
  x <- ifelse(substr(input, 7, 8) == "W", -x, x)
  x
}