FROM rocker/r-ver:4.0.3

# install required version of renv
RUN R --quiet -e "install.packages('remotes', repos = 'https://cran.rstudio.com')"
# make sure version matches what is used in the project: packageVersion('renv')
ENV RENV_VERSION 0.8.3-81
RUN R --quiet -e "remotes::install_github('rstudio/renv@${RENV_VERSION}')"

WORKDIR /app

RUN apt-get update \
  && apt-get install -yqq --no-install-recommends \
  libgdal-dev \
  libgeos-dev \
  libudunits2-dev \
  libproj-dev \
  libssl-dev \
  && apt-get clean

ENV CRAN=https://packagemanager.rstudio.com/all/__linux__/focal/latest
COPY renv.lock .
RUN R --quiet -e 'renv::restore()'

COPY nlcd.R .

WORKDIR /tmp

ENTRYPOINT ["/app/nlcd.R"]
