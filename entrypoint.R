#!/usr/local/bin/Rscript

dht::greeting()

## load libraries without messages or warnings
withr::with_message_sink("/dev/null", library(dplyr))
withr::with_message_sink("/dev/null", library(tidyr))
withr::with_message_sink("/dev/null", library(sf))
withr::with_message_sink("/dev/null", library(dht))

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

dht::check_for_column(d, "lat", d$lat)
dht::check_for_column(d, "lon", d$lon)

d_s2 <-
  d |>
  mutate(s2 = s2::s2_lnglat(d$lon, d$lat) |> s2::as_s2_cell()) |>
  filter(!is.na(s2)) |>
  mutate(
    nlcd =
      appc::get_nlcd_frac_imperv(s2, dates = replicate(length(s2), as.Date("2023-01-01"), simplify = FALSE)) |>
        purrr::map_dbl(1)
  ) |>
  transmute(
    .row = .row,
    nlcd_frac_impervious = nlcd / 100
  )

d_out <- left_join(d, d_s2, by = ".row")

## merge back on .row
dht::write_geomarker_file(
  d = d_s2,
  filename = opt$filename,
  argument = glue::glue("{opt$buffer_radius}m_buffer")
)
