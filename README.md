R interface to AEMET API
================
Sevilla R users (<http://sevillarusers.wordpress.com>)

Download climatic and meteorological data from Spanish Meteorological Agency (AEMET) using their API: <https://opendata.aemet.es>.

Installation
------------

``` r
library(devtools)
install_github("SevillaR/aemet")
```

Requirements
------------

To be able to download data from AEMET you will need a free API key which you can get at <https://opendata.aemet.es>.

Usage
-----

``` r
library(aemet)
stations <- aemet_stations(apikey)
grazalema <- get_aemet_normalized(apikey, "5911A")
```
