# nlcd <a href='https://degauss-org.github.io/DeGAUSS/'> <img src='https://github.com/degauss-org/degauss_template/blob/master/DeGAUSS_hex.png' align='right' height='138.5' /></a>

> add NLCD landcover variables to geocoded data

[![GitHub Latest Tag](https://img.shields.io/github/v/tag/degauss-org/nlcd)](https://github.com/degauss-org/nlcd/releases)

## DeGAUSS example call

If `my_address_file_geocoded.csv` is a file in the current working directory with coordinate columns named `lat` and `lon`, then

```sh
docker run --rm -v $PWD:/tmp ghcr.io/degauss-org/nlcd:0.1 my_address_file_geocoded.csv
```

will produce `my_address_file_geocoded_nlcd_v0.1.csv` with addeded columns named `nlcd_cell`, `year`, `impervious`,	`landcover_class`, `landcover`,	`green`, and `road_type`.

Definitions for these variables can be found [here](https://github.com/geomarker-io/addNlcdData#nlcd-data-details).

## geomarker methods

This container was built using the [addNlcdData](https://github.com/geomarker-io/addNlcdData) package.

## geomarker data

- Landcover data was downloaded from [mrlc.gov](mrlc.gov)
- NLCD data is stored in chunks as [fst](https://github.com/fstpackage/fst) files at [`s3://geomarker/nlcd/nlcd_fst/`](https://geomarker.s3.us-east-2.amazonaws.com/nlcd/nlcd_fst)
- Detailed information for how data was converted to chunk files can be found [here](https://github.com/geomarker-io/nlcd_raster_to_fst).

## DeGAUSS details

For detailed documentation on DeGAUSS, including general usage and installation, please see the [DeGAUSS homepage](https://degauss.org).
