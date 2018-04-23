# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/scipy-notebook

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    tzdata \
    gfortran \
    gcc && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER $NB_UID

# R packages including IRKernel which gets installed globally.
RUN conda config --system --append channels r && \
    conda install --quiet --yes \
    'rpy2' \
    'r-base=3.4.1' \
    'r-irkernel' \
    'r-plyr' \
    'r-devtools' \
    'r-tidyverse' \
    'r-shiny' \
    'r-rmarkdown' \
    'r-forecast' \
    'r-rsqlite' \
    'r-reshape2' \
    'r-nycflights13' \
    'r-caret' \
    'r-rcurl' \
    'r-crayon' \
    'r-randomforest' \
    'r-rmysql' && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN echo "source('https://www.bioconductor.org/biocLite.R'); biocLite('maftools')" | R --no-save
RUN echo "load.lib<-c('httr','jsonlite','dplyr','gplots','RColorBrewer','xml2','repr','VennDiagram'); install.lib<-load.lib[!load.lib %in% installed.packages()]; for(lib in install.lib) install.packages(lib,dependences=TRUE)" | R --no-save

COPY custom/custom.css /home/$NB_USER/.jupyter/custom/custom.css
