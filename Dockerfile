# Gunakan base image Shiny dari rocker
FROM rocker/shiny:latest

# Install dependensi sistem tambahan yang dibutuhkan beberapa package R
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install package R yang diperlukan aplikasi
RUN R -e "install.packages(c( \
  'shiny', 'shinydashboard', 'plotly', 'dplyr', 'lubridate', \
  'DT', 'shinyWidgets', 'DBI', 'RPostgres' \
), repos='https://cloud.r-project.org')"

# Salin semua file dari direktori lokal ke dalam container
COPY . /srv/app

# Ubah kepemilikan file agar bisa dijalankan oleh user shiny
RUN chown -R shiny:shiny /srv/app

# Gunakan user shiny
USER shiny

# Jalankan aplikasi
CMD R -e "port <- Sys.getenv('PORT'); if (port == '') port <- 3838; print(paste('Running on port:', port)); shiny::runApp('/srv/app', host = '0.0.0.0', port = as.numeric(port))"
