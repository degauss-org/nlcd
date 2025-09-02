# nlcd <a href='https://degauss.org'><img src='https://github.com/degauss-org/degauss_hex_logo/raw/main/PNG/degauss_hex.png' align='right' height='138.5' /></a>

[![](https://img.shields.io/github/v/release/degauss-org/nlcd?color=469FC2&label=version&sort=semver)](https://github.com/degauss-org/nlcd/releases)
[![container build status](https://github.com/degauss-org/nlcd/workflows/build-deploy-release/badge.svg)](https://github.com/degauss-org/nlcd/actions/workflows/build-deploy-release.yaml)

## Using

If `my_address_file_geocoded.csv` is a file in the current working directory with coordinate columns named `lat` and `lon`, then the [DeGAUSS command](https://degauss.org/using_degauss.html#DeGAUSS_Commands):

```sh
docker run --rm -v $PWD:/tmp ghcr.io/degauss-org/nlcd:1.0.1 my_address_file_geocoded.csv
```

will produce `my_address_file_geocoded_nlcd_1.0.1_400m_buffer.csv` with an added column, `nlcd_frac_impervious`, which is the [fractional percent imperviousness](https://www.mrlc.gov/data/type/fractional-impervious-surface) among all 30 x 30 meter NLCD cells within a 400 m buffer of each input point. 
Currently, 2023 NLCD from the [annual NLCD data product](https://www.mrlc.gov/data/project/annual-nlcd) is returned. 

> Earlier versions (< 1.0.1) of degauss-org/nlcd relied on cloud-hosted data that are not currently available. Use a more recent version (>=1.0.1) that instead relies on data hosted directly on the Multi-Resolution Land Characteristics Consortium webpage.

### Optional Argument

The default buffer radius is 400 meters, but can be changed by supplying an optional argument to the degauss command. For example,

```sh
docker run --rm -v $PWD:/tmp ghcr.io/degauss-org/nlcd:1.0.1 my_address_file_geocoded.csv 800
```

will produce `my_address_file_geocoded_nlcd_1.0.1_800m_buffer.csv`, and all output will be values within an 800 m buffer. 

## Geomarker Methods and Data

This container was built using the [appc](https://geomarker.io/appc) package.

## DeGAUSS Details

For detailed documentation on DeGAUSS, including general usage and installation, please see the [DeGAUSS homepage](https://degauss.org).
