R interface to AEMET API
================
Sevilla R users (<http://sevillarusers.wordpress.com>)

[![Travis build status](https://travis-ci.org/SevillaR/aemet.svg?branch=master)](https://travis-ci.org/SevillaR/aemet) [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/SevillaR/aemet?branch=master&svg=true)](https://ci.appveyor.com/project/SevillaR/aemet)

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
grazalema <- aemet_climatology_station("5911A", apikey)
```
