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
    'r-base=3.4.3' \
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
    'r-rmysql' \
    'r-gplots' \
    'r-gtools' \
    'r-catools' \
    && conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

RUN echo "load.lib<-c('httr','jsonlite','dplyr','gplots','ggplot2','ggpubr','RColorBrewer','xml2','repr','VennDiagram'); install.lib<-load.lib[!load.lib %in% installed.packages()]; install.packages(install.lib,dependencies=TRUE, repos='http://cran.us.r-project.org', type='source')" | R --no-save
RUN echo "source('https://www.bioconductor.org/biocLite.R'); load.s3<-c('maftools', 'phyloseq'); install.s3<-load.s3[!load.s3 %in% installed.packages()]; for(s3 in install.s3) biocLite(s3);" | R --no-save

#COPY custom/custom.css /home/$NB_USER/.jupyter/custom/custom.css
