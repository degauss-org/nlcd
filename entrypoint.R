#!/usr/local/bin/Rscript

dht::greeting()

## load libraries without messages or warnings
withr::with_message_sink("/dev/null", library(dplyr))
withr::with_message_sink("/dev/null", library(tidyr))
withr::with_message_sink("/dev/null", library(sf))

doc <- "
      Usage:
      entrypoint.R <filename> [<buffer_radius>]
      "

opt <- docopt::docopt(doc)

## for interactive testing
## opt <- docopt::docopt(doc, args = 'test/my_address_file_geocoded.csv')

if (is.null(opt$buffer_radius)) {
  opt$buffer_radius <- 400
}

message("reading input file...")
d <- dht::read_lat_lon_csv(opt$filename)

dht::check_for_column(d, 'lat', d$lat)
dht::check_for_column(d, 'lon', d$lon)

## get ncld cell numbers
message('finding nlcd cell numbers for each point...')
d <- addNlcdData::get_nlcd_cell_numbers_points(d)

## join nlcd data
message('downloading and merging NLCD data...')
if (opt$buffer_radius == 0){
  d <- suppressMessages(addNlcdData::get_nlcd_data(d))
  argument_file_name <- "points"
} else {
  d <- suppressMessages(addNlcdData::get_nlcd_data_point_buffer(d, buffer_m = opt$buffer_radius))
  argument_file_name <- glue::glue("{opt$buffer_radius}m_buffer")
}

## merge back on .row after unnesting .rows into .row
dht::write_geomarker_file(d = d, filename = opt$filename, argument = argument_file_name)
