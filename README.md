# nlcd <a href='https://degauss.org'><img src='https://github.com/degauss-org/degauss_hex_logo/raw/main/PNG/degauss_hex.png' align='right' height='138.5' /></a>

[![](https://img.shields.io/github/v/release/degauss-org/nlcd?color=469FC2&label=version&sort=semver)](https://github.com/degauss-org/nlcd/releases)
[![container build status](https://github.com/degauss-org/nlcd/workflows/build-deploy-release/badge.svg)](https://github.com/degauss-org/nlcd/actions/workflows/build-deploy-release.yaml)

## Using

If `my_address_file_geocoded.csv` is a file in the current working directory with coordinate columns named `lat` and `lon`, then the [DeGAUSS command](https://degauss.org/using_degauss.html#DeGAUSS_Commands):

```sh
docker run --rm -v $PWD:/tmp ghcr.io/degauss-org/nlcd:0.2.0 my_address_file_geocoded.csv
```

will produce `my_address_file_geocoded_nlcd_0.2.0_400m_buffer.csv` with the following added columns describing the land classification withing a 400 meter buffer of each point:

- **`impervious`**: average percent impervious of all nlcd cells overlapping the buffer
- **`green`**: percent of `green = TRUE` nlcd cells overlapping buffer (`green = TRUE` if landcover classification in any category except water, ice/snow, developed medium intensity, developed high intensity, rock/sand/clay)
- **`primary_urban`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of primary urban
- **`primary_rural`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of primary rural
- **`secondary_urban`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of secondary urban
- **`secondary_rural`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of secondary rural
- **`tertiary_urban`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of tertiary urban
- **`tertiary_rural`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of tertiary rural
- **`thinned_urban`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of thinned urban
- **`thinned_rural`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of thinned rural
- **`nonroad_urban`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of nonroad urban
- **`nonroad_rural`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of nonroad rural
- **`energyprod_urban`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of energy production urban
- **`energyprod_rural`**: percent of nlcd cells overlapping buffer with an impervious descriptor classification of energy production rural
- **`nonimpervious`**: percent of ncld cells overlapping polygon not classified as any of the impervious descriptior categories

### Optional Argument

The default buffer radius is 400 meters, but can be changed by supplying an optional argument to the degauss command. For example,

```sh
docker run --rm -v $PWD:/tmp ghcr.io/degauss-org/nlcd:0.2.0 my_address_file_geocoded.csv 800
```

will produce `my_address_file_geocoded_roads_0.2.0_800m_buffer.csv`, and all output will be values within an 800 m buffer. 

## Geomarker Methods

This container was build using the [addNlcdData](https://geomarker.io/addNlcdData) package.

## Geomarker Data

- Landcover data was downloaded from [mrlc.gov](mrlc.gov).
- NLCD data is stored in chunks as [fst](https://github.com/fstpackage/fst) files at [`s3://geomarker/nlcd/nlcd_fst/`](https://geomarker.s3.us-east-2.amazonaws.com/nlcd/nlcd_fst).
- Detailed information for how data was converted to chunk files can be found [here](https://github.com/geomarker-io/nlcd_raster_to_fst).

## DeGAUSS Details

For detailed documentation on DeGAUSS, including general usage and installation, please see the [DeGAUSS homepage](https://degauss.org).
