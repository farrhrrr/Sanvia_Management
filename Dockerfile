FROM rocker/shiny-verse:4.3.2

RUN apt-get update && apt-get install -y \
    libpq-dev libssl-dev libcurl4-openssl-dev libxml2-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN R -e "install.packages(c('shinydashboard', 'plotly', 'DT', 'shinyWidgets', 'DBI', 'RPostgres'), repos='https://cloud.r-project.org')"

COPY app.R /app/app.R
WORKDIR /app

EXPOSE 8080
ENV PORT 8080

CMD ["R", "-e", "shiny::runApp('/app', host='0.0.0.0', port=as.numeric(Sys.getenv('PORT', '8080')))"]
