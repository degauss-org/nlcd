#!/usr/local/bin/Rscript

dht::greeting(geomarker_name = 'nlcd', version = '0.1', description = 'adds landcover variables to data')

dht::qlibrary(dplyr)
dht::qlibrary(tidyr)
dht::qlibrary(sf)

doc <- '
      Usage:
      nlcd.R <filename>
      '

opt <- docopt::docopt(doc)
## for interactive testing
## opt <- docopt::docopt(doc, args = 'test/my_address_file_geocoded.csv')

message('reading input file...')
d <- dht::read_lat_lon_csv(opt$filename, nest_df = F)

dht::check_for_column(d, 'lat', d$lat)
dht::check_for_column(d, 'lon', d$lon)

## get ncld cell numbers
message('finding nlcd cell numbers for each point...')
d <- addNlcdData::get_nlcd_cell_numbers_points(d)

## join nlcd data
message('downloading and merging NLCD data...')
d <- addNlcdData::get_nlcd_data(d)

## merge back on .row after unnesting .rows into .row
dht::write_geomarker_file(d = d,
                          filename = opt$filename,
                          geomarker_name = 'nlcd',
                          version = '0.1')
