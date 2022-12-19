FROM rocker/r-ver:4.2.2

# DeGAUSS container metadata
ENV degauss_name="nlcd"
ENV degauss_version="0.2.2"
ENV degauss_description="land cover (imperviousness, land use, greenness)"
ENV degauss_argument="buffer radius in meters [default: 400]"

# add OCI labels based on environment variables too
LABEL "org.degauss.name"="${degauss_name}"
LABEL "org.degauss.version"="${degauss_version}"
LABEL "org.degauss.description"="${degauss_description}"
LABEL "org.degauss.argument"="${degauss_argument}"

RUN R --quiet -e "install.packages('remotes', repos = c(CRAN = 'https://packagemanager.rstudio.com/all/__linux__/focal/latest'))"

RUN R --quiet -e "remotes::install_github('rstudio/renv@0.15.4')"

WORKDIR /app

RUN apt-get update \
    && apt-get install -yqq --no-install-recommends \
    libgdal-dev \
    libgeos-dev \
    libudunits2-dev \
    libproj-dev \
    && apt-get clean

COPY renv.lock .

RUN R --quiet -e "renv::restore()"

COPY entrypoint.R .

WORKDIR /tmp

ENTRYPOINT ["/app/entrypoint.R"]
