FROM rocker/r-ver:4.4.1

# DeGAUSS container metadata
ENV degauss_name="nlcd"
ENV degauss_version="1.0.0"
ENV degauss_description="land cover fractional imperviousness"
ENV degauss_argument="buffer radius in meters [default: 400]"

# add OCI labels based on environment variables too
LABEL "org.degauss.name"="${degauss_name}"
LABEL "org.degauss.version"="${degauss_version}"
LABEL "org.degauss.description"="${degauss_description}"
LABEL "org.degauss.argument"="${degauss_argument}"

RUN R --quiet -e "install.packages('remotes', repo = c(CRAN = 'https://packagemanager.posit.co/cran/latest'))"

RUN R --quiet -e "remotes::install_github('rstudio/renv@v1.0.10')"

WORKDIR /app

RUN apt-get update \
    && apt-get install -yqq --no-install-recommends \
    libgdal-dev \
    libgeos-dev \
    libudunits2-dev \
    libproj-dev \
    && apt-get clean

COPY renv.lock .

RUN R --quiet -e "renv::restore(repos = c(CRAN = 'https://packagemanager.posit.co/cran/__linux__/jammy/latest'))"

COPY entrypoint.R .

WORKDIR /tmp

ENTRYPOINT ["/app/entrypoint.R"]
