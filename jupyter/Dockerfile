# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/scipy-notebook:d4cbf2f80a2a 

USER root

RUN pip install --upgrade nbconvert==5.4.1

#
# R pre-requisites
#  https://github.com/rocker-org/rocker/blob/master/r-base/Dockerfile
#
## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENV R_BASE_VERSION 3.6.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    autoconf \
    ca-certificates \
    fonts-dejavu \
    fonts-texgyre \
    gfortran \
    gcc \
    less \
    locales \
    libssl1.0.0 \
    libcurl4-openssl-dev \
    libssl-dev \
    tzdata \
    vim \
    zlib1g \
    zlib1g-dev
    
## Now install R and littler, and create a link for littler in /usr/local/bin
#RUN apt-get update \
#	&& apt-get install -t unstable -y --no-install-recommends \
#		littler \
#    r-cran-littler \
#		r-base=${R_BASE_VERSION}-* \
#		r-base-dev=${R_BASE_VERSION}-* \
#		r-recommended=${R_BASE_VERSION}-* \
#	&& ln -s /usr/lib/R/site-library/littler/examples/install.r /usr/local/bin/install.r \
#	&& ln -s /usr/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r \
#	&& ln -s /usr/lib/R/site-library/littler/examples/installGithub.r /usr/local/bin/installGithub.r \
#	&& ln -s /usr/lib/R/site-library/littler/examples/testInstalled.r /usr/local/bin/testInstalled.r \
#	&& install.r docopt \
#	&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds \

RUN apt-get clean \
 	&& rm -rf /var/lib/apt/lists/*

#
# R packages including IRKernel which gets installed globally.
# See https://github.com/rocker-org/rocker/blob/master/r-base/Dockerfile
#
RUN conda config --system --append channels r && \
    conda install --quiet --yes \
    'rpy2' \
    "r-base=$R_BASE_VERSION" \
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

RUN wget https://github.com/arq5x/lumpy-sv/releases/download/0.3.0/lumpy-sv.tar.gz; \
    tar -zxvf lumpy-sv.tar.gz lumpy-sv; rm lumpy-sv.tar.gz; \
    cd lumpy-sv; make; cp bin/* /usr/local/bin/.; \
    rm -rf data/ src/ .git;

COPY resources/templates/ /opt/conda/lib/python3.7/site-packages/notebook/templates

USER $NB_UID

COPY resources/custom.js /home/$NB_USER/.jupyter/custom/
COPY resources/jupyter_notebook_config.py /home/$NB_USER/.jupyter/tmp.py
RUN cat /home/$NB_USER/.jupyter/tmp.py >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py && rm /home/$NB_USER/.jupyter/tmp.py

RUN echo "load.lib<-c('httr','jsonlite','dplyr','gplots','ggplot2','ggpubr','RColorBrewer','xml2','repr','VennDiagram'); install.lib<-load.lib[!load.lib %in% installed.packages()]; install.packages(install.lib,dependencies=TRUE, repos='http://cran.us.r-project.org', type='source')" | R --no-save
RUN echo 'if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager",dependencies=TRUE, repos="http://cran.us.r-project.org"); BiocManager::install(ask=FALSE)' | R --no-save
RUN echo "load.s3<-c('maftools', 'phyloseq', 'DESeq2', 'dada2', 'vcfR'); install.s3<-load.s3[!load.s3 %in% installed.packages()]; for(s3 in install.s3) BiocManager::install(s3, ask=FALSE);" | R --no-save
