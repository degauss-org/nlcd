# nlcd <a href='https://degauss.org'><img src='https://github.com/degauss-org/degauss_hex_logo/raw/main/PNG/degauss_hex.png' align='right' height='138.5' /></a>

[![](https://img.shields.io/github/v/release/degauss-org/nlcd?color=469FC2&label=version&sort=semver)](https://github.com/degauss-org/nlcd/releases)
[![container build status](https://github.com/degauss-org/nlcd/workflows/build-deploy-release/badge.svg)](https://github.com/degauss-org/nlcd/actions/workflows/build-deploy-release.yaml)

## Using

If `my_address_file_geocoded.csv` is a file in the current working directory with coordinate columns named `lat` and `lon`, then the [DeGAUSS command](https://degauss.org/using_degauss.html#DeGAUSS_Commands):

```sh
docker run --rm -v $PWD:/tmp ghcr.io/degauss-org/nlcd:0.2.1 my_address_file_geocoded.csv
```

will produce `my_address_file_geocoded_nlcd_0.2.1_400m_buffer.csv` with the following added columns describing the [land classification](https://www.mrlc.gov/data/legends/national-land-cover-database-class-legend-and-description) within a 400 meter buffer radius of each point:

- **`impervious`**: average percent impervious of all nlcd cells overlapping the buffer
- **`green`**: percent of `green = TRUE` nlcd cells overlapping buffer (`green = TRUE` if landcover classification in any category except water, ice/snow, developed medium intensity, developed high intensity, rock/sand/clay)
- **impervious descriptors** are defined as the percent of nlcd cells in the buffer with a specific impervious descriptor classification, and separate columns will be added for each classification, including:
  - **`primary_urban`**: primary urban roadway
  - **`primary_rural`**: primary rural roadway
  - **`secondary_urban`**: secondary urban roadway
  - **`secondary_rural`**: secondary rural roadway
  - **`tertiary_urban`**: tertiary urban roadway
  - **`tertiary_rural`**: tertiary rural roadway
  - **`thinned_urban`**: thinned urban roadway
  - **`thinned_rural`**: thinned rural roadway
  - **`nonroad_urban`**: nonroad urban
  - **`nonroad_rural`**: nonroad rural
  - **`energyprod_urban`**: energy production urban
  - **`energyprod_rural`**: energy production rural
  - **`nonimpervious`**: not classified as any of the impervious descriptior categories

NLCD uses the following definitions for impervious descriptors categories:

- Primary roadway: Interstates and other major roads
- Secondary roadway: Non-interstate highways
- Tertiary roadway: Any two-lane road
- Thinned roadway: Small tertiary roads that generally are not paved
- Non-road: Developed areas that are generally not roads or energy production; includes residential/commercial/industrial areas, parks, and golf courses
- Energy production: Well pads or wind turbines

### Optional Argument

The default buffer radius is 400 meters, but can be changed by supplying an optional argument to the degauss command. For example,

```sh
docker run --rm -v $PWD:/tmp ghcr.io/degauss-org/nlcd:0.2.1 my_address_file_geocoded.csv 800
```

will produce `my_address_file_geocoded_nlcd_0.2.1_800m_buffer.csv`, and all output will be values within an 800 m buffer. 

## Geomarker Methods

This container was built using the [addNlcdData](https://geomarker.io/addNlcdData) package.

## Geomarker Data

- Landcover data was downloaded from [mrlc.gov](mrlc.gov).
- NLCD data is stored in chunks as [fst](https://github.com/fstpackage/fst) files at [`s3://geomarker/nlcd/nlcd_fst/`](https://geomarker.s3.us-east-2.amazonaws.com/nlcd/nlcd_fst).
- Detailed information for how data was converted to chunk files can be found [here](https://github.com/geomarker-io/nlcd_raster_to_fst).

## DeGAUSS Details

For detailed documentation on DeGAUSS, including general usage and installation, please see the [DeGAUSS homepage](https://degauss.org).
