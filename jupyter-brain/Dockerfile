# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/scipy-notebook:9e8682c9ea54

USER root

# R pre-requisites
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    fonts-dejavu \
    tzdata \
    gfortran \
    gcc \
    libssl1.0.0 \
    libcurl4-openssl-dev \
    libssl-dev \
    zlib1g \
    zlib1g-dev && apt-get clean && \
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
RUN echo "source('https://www.bioconductor.org/biocLite.R'); load.s3<-c('maftools', 'phyloseq', 'DESeq2', 'dada2', 'vcfR'); install.s3<-load.s3[!load.s3 %in% installed.packages()]; for(s3 in install.s3) biocLite(s3);" | R --no-save

USER root
COPY resources/templates/ /opt/conda/lib/python3.6/site-packages/notebook/templates
USER $NB_UID

COPY resources/custom.js /home/$NB_USER/.jupyter/custom/
COPY resources/jupyter_notebook_config.py /home/$NB_USER/.jupyter/tmp.py
RUN cat /home/$NB_USER/.jupyter/tmp.py >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py && rm /home/$NB_USER/.jupyter/tmp.py


# this section is based off of: https://github.com/uc-cdis/bc-cwl/blob/master/brainCommonPipelineDocker4CWL/docker-freesurfer-master/Dockerfile
USER root

COPY license /usr/local/freesurfer/license.txt

ENV FREESURFER_HOME /usr/local/freesurfer
ENV FMRI_ANALYSIS_DIR /usr/local/freesurfer/fsfast
ENV FSFAST_HOME /usr/local/freesurfer/fsfast
ENV FUNCTIONALS_DIR /usr/local/freesurfer/sessions
ENV LOCAL_DIR /usr/local/freesurfer/local
ENV MINC_BIN_DIR /usr/local/freesurfer/mni/bin
ENV MINC_LIB_DIR /usr/local/freesurfer/mni/lib
ENV MNI_DATAPATH /usr/local/freesurfer/mni/data
ENV MNI_DIR /usr/local/freesurfer/mni
ENV MNI_PERL5LIB /usr/local/freesurfer/mni/share/perl5
ENV PERL5LIB /usr/local/freesurfer/mni/share/perl5
ENV SUBJECTS_DIR /usr/local/freesurfer/subjects
ENV PATH $PATH:/usr/local/freesurfer/bin:/usr/local/freesurfer/fsfast/bin:/usr/local/freesurfer/tktools:/usr/local/freesurfer/mni/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ADD extract_subfields.sh /mnt/
ADD initialize_subDir.sh /mnt/
ADD extract_subcortical.sh /mnt/
ADD outlierDetection.sh /mnt/

RUN apt-get update && apt-get install -y --no-install-recommends curl tar tcsh libglu1-mesa libgomp1 libjpeg62 libxext6 libxtst6  libxt6 libxt-dev libxmu6 \
  && curl ftp://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.0/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.0.tar.gz | tar xvz -C /usr/local \
  && apt-get install -y --no-install-recommends jq bc libsys-hostname-long-perl && ldconfig && mkdir -p /N/u /N/home /N/dc2 /N/soft \
  && curl "https://surfer.nmr.mgh.harvard.edu/fswiki/MatlabRuntime?action=AttachFile&do=get&target=runtime2012bLinux.tar.gz" -o "/usr/local/freesurfer/runtime2012b.tar.gz" \
  && tar xf /usr/local/freesurfer/runtime2012b.tar.gz -C /usr/local/freesurfer/ \
  && /bin/rm /usr/local/freesurfer/runtime2012b.tar.gz \
  && apt-get remove -y curl \
  && rm -rf /var/lib/apt/lists/*


USER $NB_UID