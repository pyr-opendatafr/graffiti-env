# Base image
FROM rocker/shiny:4.1.2

# Install required linux librairies
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends libpq-dev \
                                               libssl-dev \
                                               libxml2-dev \
                                               libcurl4-openssl-dev \
                                               build-essential \
                                               libudunits2-dev \
                                               libharfbuzz-dev \ 
                                               libfribidi-dev \
                                               libfreetype6-dev \
                                               libpng-dev \
                                               libtiff5-dev \
                                               libjpeg-dev \
                                               libfontconfig1-dev \
                                               pandoc \
                                               wget \
                                               graphviz \
                                               perl && \
                                               install2.r rmarkdown

ENV no_proxy=".sspcloud.fr, .mesos,.thisdcos.directory,.dcos.directory,.zk,127.0.0.1,localhost,.intra,.insee.test,.innovation.insee.eu,.mesos,master.mesos,.thisdcos.directory,.dcos.directory,.zk,127.0.0.1,10.192.255.21,10.192.255.22,10.192.254.31,10.192.254.32,10.192.254.33,10.192.253.51,10.192.253.52,10.192.253.53,10.192.253.54,10.192.253.55,10.192.253.56,10.192.253.57,10.192.253.58,10.192.253.59,10.192.253.61,10.192.253.62,10.192.253.63,10.192.253.64,10.192.1.41,10.192.1.42,9.0.0.0/8,localhost" 

# Install R dependencies
RUN R -e "install.packages(c('httr', 'xml2', 'tibble', 'crayon', 'openssl', 'rappdirs', 'shiny', 'shinydashboard', 'shinydashboardPlus', 'shinyWidgets', 'shinyjs', 'DT', 'magrittr', 'lubridate', 'rlang', 'ggplot2', 'plotly', 'rmarkdown', 'RColorBrewer', 'ggthemes', 'png', 'grid', 'purrr'), repos='https://cran.rstudio.com/', dependencies=TRUE)"

# Install R-Insee-Data package
RUN R -e "devtools::install_github('pyr-opendatafr/R-Insee-Data')"

# Install local R graffiti package and its dependencies
COPY graffiti/ ./graffiti
RUN Rscript -e 'install.packages("./graffiti", repos = NULL, type="source")'

# Expose port where shiny app will broadcast
ARG SHINY_PORT=3838
EXPOSE $SHINY_PORT
RUN echo "local({options(shiny.port = ${SHINY_PORT}, shiny.host = '0.0.0.0')})" >> /usr/local/lib/R/etc/Rprofile.site

# install tinytex
RUN Rscript -e 'tinytex::install_tinytex()'

# Endpoint
CMD ["Rscript", "-e", "graffiti::graffiti()"]

#repos = 'https://cran.rstudio.com/'
