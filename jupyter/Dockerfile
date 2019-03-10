# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.
FROM jupyter/scipy-notebook:9e8682c9ea54

USER root

ENV GOPATH /home/$NB_USER/go
ENV GOROOT /usr/local/go/
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# Install gen3-fuse
RUN apt-get update && apt-get install -y --no-install-recommends curl tar fuse \
  && curl -O https://dl.google.com/go/go1.12.linux-amd64.tar.gz \
  && tar -C /usr/local -xzf go1.12.linux-amd64.tar.gz \
  && export PATH=$PATH:/usr/local/go/bin \
  && mkdir $GOPATH && cd $GOPATH && mkdir src \
  && cd src \
  && git clone https://github.com/uc-cdis/gen3-fuse.git \
  && cd gen3-fuse/ && git checkout fix/export-to-workspace && git pull origin fix/export-to-workspace \
  && ./build.sh \
  && chmod 777 gen3fuse \
  && mv gen3fuse /usr/local/bin/gen3fuse \
  && mv config.yaml /home/$NB_USER/fuse-config.yaml \
  && export PATH=$PATH:/usr/local/bin/gen3fuse \
  && echo "export PATH=$PATH:/usr/local/bin/gen3fuse" >> /home/$NB_USER/.bashrc \
  && rm  -rf $GOPATH && rm /home/$NB_USER/go1.12.linux-amd64.tar.gz \
  && apt-get remove -y curl \
  && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade nbconvert==5.4.1

# R pre-requisites
# RUN apt-get update && \
#     apt-get install -y --no-install-recommends \
#     fonts-dejavu \
#     tzdata \
#     gfortran \
#     gcc \
#     libssl1.0.0 \
#     libcurl4-openssl-dev \
#     libssl-dev \
#     zlib1g \
#     zlib1g-dev && apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

USER $NB_UID

# R packages including IRKernel which gets installed globally.
# RUN conda config --system --append channels r && \
#     conda install --quiet --yes \
#     'rpy2' \
#     'r-base=3.4.3' \
#     'r-irkernel' \
#     'r-plyr' \
#     'r-devtools' \
#     'r-tidyverse' \
#     'r-shiny' \
#     'r-rmarkdown' \
#     'r-forecast' \
#     'r-rsqlite' \
#     'r-reshape2' \
#     'r-nycflights13' \
#     'r-caret' \
#     'r-rcurl' \
#     'r-crayon' \
#     'r-randomforest' \
#     'r-rmysql' \
#     'r-gplots' \
#     'r-gtools' \
#     'r-catools' \
#     && conda clean -tipsy && \
#     fix-permissions $CONDA_DIR && \
#     fix-permissions /home/$NB_USER


# RUN echo "load.lib<-c('httr','jsonlite','dplyr','gplots','ggplot2','ggpubr','RColorBrewer','xml2','repr','VennDiagram'); install.lib<-load.lib[!load.lib %in% installed.packages()]; install.packages(install.lib,dependencies=TRUE, repos='http://cran.us.r-project.org', type='source')" | R --no-save
# RUN echo "source('https://www.bioconductor.org/biocLite.R'); load.s3<-c('maftools', 'phyloseq', 'DESeq2', 'dada2', 'vcfR'); install.s3<-load.s3[!load.s3 %in% installed.packages()]; for(s3 in install.s3) biocLite(s3);" | R --no-save

USER root
COPY resources/templates/ /opt/conda/lib/python3.6/site-packages/notebook/templates
USER $NB_UID

COPY resources/custom.js /home/$NB_USER/.jupyter/custom/
COPY resources/jupyter_notebook_config.py /home/$NB_USER/.jupyter/tmp.py
RUN cat /home/$NB_USER/.jupyter/tmp.py >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py && rm /home/$NB_USER/.jupyter/tmp.py

# Notice that we switch back to user $NB_UID at the end of the CMD call, so that the user does not have sudo nor root privileges.
USER root
RUN sudo mknod -m 666 /dev/fuse c 10 229 && sudo chmod 777 /dev/fuse && sudo chmod -R 777 /dev/fuse
CMD sudo chmod 777 /dev/fuse && sudo chmod -R 777 /dev/fuse && start-notebook.sh && su $NB_UID
