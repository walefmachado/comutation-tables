FROM rocker/shiny
RUN R -e "install.packages(c('shinydashboard', 'tidyverse', 'shiny', 'DT'), repos='https://cran.rstudio.com/')"
COPY /global/ /srv/shiny-server/
EXPOSE 3838
CMD ["/usr/bin/shiny-server.sh"]
