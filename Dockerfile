FROM rocker/r-ver:4.3.2    

# Sistem & package R
RUN apt-get update && apt-get install -y \
      libssl-dev libcurl4-openssl-dev libxml2-dev libharfbuzz-dev \
      libfribidi-dev libfontconfig1-dev libfreetype6-dev libpng-dev \
      libtiff5-dev libjpeg-dev libpq-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c('shiny','shinydashboard','plotly','dplyr', \
            'lubridate','DT','shinyWidgets','DBI','RPostgres'), \
            repos='https://cloud.r-project.org')"

# Salin app
COPY app.R /opt/app/app.R
WORKDIR /opt/app

# Port di-expose → nilai diganti Railway saat runtime
EXPOSE 8080
ENV PORT 8080

# Jalankan Shiny
CMD ["R", "-e", "shiny::runApp('/opt/app', \
      host='0.0.0.0', port=as.numeric(Sys.getenv('PORT', '8080')))"]
