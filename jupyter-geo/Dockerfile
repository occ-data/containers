FROM alpine:3.5
LABEL maintainer "Zac Flamig <zflamig@uchicago.edu>"

RUN apk --no-cache add \
        bash \
	ca-certificates \
	cmake \
	freetype-dev \
	g++ \
	gcc \
	gfortran \
	git \
	lapack-dev \
	libffi-dev \
	libpng-dev \
	libstdc++ \
	linux-headers \
	m4 \
	make \
	musl-dev \
	openssl-dev \
	python3 \
	python3-dev \
        tini \
	wget \
	zlib-dev \
	&& ln -s /usr/include/locale.h /usr/include/xlocale.h \
	&& pip3 install --upgrade pip \
	&& python3 -m pip --no-cache-dir install \
	numpy

RUN apk --no-cache add \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        proj4-dev

# HDF5 Installation
RUN wget https://www.hdfgroup.org/package/bzip2/?wpdmdl=4300 \
        && mv "index.html?wpdmdl=4300" hdf5-1.10.1.tar.bz2 \
        && tar xf hdf5-1.10.1.tar.bz2 \
        && cd hdf5-1.10.1 \
        && ./configure --prefix=/usr --enable-cxx --with-zlib=/usr/include,/usr/lib/x86_64-linux-gnu \
        && make -j4 \
        && make install \
        && cd .. \
        && rm -rf hdf5-1.10.1 \
        && rm -rf hdf5-1.10.1.tar.bz2 \
	&& export HDF5_DIR=/usr

RUN HDF5_LIBDIR=/usr/lib HDF5_INCDIR=/usr/include python3 -m pip --no-cache-dir install \
	--no-binary=h5py h5py

# NetCDF Installation
RUN wget https://github.com/Unidata/netcdf-c/archive/v4.4.1.1.tar.gz \
        && tar xf v4.4.1.1.tar.gz \
        && cd netcdf-c-4.4.1.1 \
        && ./configure --prefix=/usr \
        && make -j4 \
        && make install \
        && cd .. \
        && rm -rf netcdf-c-4.4.1.1 \
        && rm -rf v4.4.1.1.tar.gz

# GEOS Installation
RUN wget http://download.osgeo.org/geos/geos-3.6.2.tar.bz2 \
        && tar xf geos-3.6.2.tar.bz2 \
        && cd geos-3.6.2 \
        && ./configure --prefix=/usr \
        && make -j4 \
        && make install \
        && cd .. \
        && rm -rf geos-3.6.2 \
        && rm -rf geos-3.6.2.tar.bz2

# GDAL Installation
RUN git clone https://github.com/OSGeo/gdal.git /gdalgit \
        && cd /gdalgit/gdal \
        && ./configure --prefix=/usr \
        && make \
        && make install \
	&& cd / \
	&& rm -rf gdalgit

RUN HDF5_LIBDIR=/usr/lib HDF5_INCDIR=/usr/include python3 -m pip --no-cache-dir install \
        boto3 \
        cartopy \
        dask-kubernetes \
        fiona \
        gdal \
        geopandas \
        jupyterhub \
        jupyterlab \
        matplotlib \
        netcdf4 \
	notebook \
        pandas \
        pyproj \
	requests \
        https://github.com/matplotlib/basemap/archive/v1.1.0.tar.gz \
        scipy \
        scikit-learn \
        shapely \
	&& mkdir /notebooks

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Configure environment
ENV CONDA_DIR /opt/conda
ENV PATH /usr/local/bin:$PATH
ENV SHELL /bin/bash
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/$NB_USER
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Create jovyan user with UID=1000 and in the 'users' group
RUN adduser -H -D -s /bin/bash -u $NB_UID $NB_USER && \
    mkdir -p $HOME/work && \
    chown -R $NB_USER $HOME

EXPOSE 8888
WORKDIR /home/$NB_USER/work

# Configure container startup
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["start-notebook.sh"]

# Add local files as late as possible to avoid cache busting
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
COPY start-singleuser.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

COPY resources/custom.js /home/$NB_USER/.jupyter/custom/
COPY resources/jupyter_notebook_config.py /home/$NB_USER/.jupyter/tmp.py
RUN cat /home/$NB_USER/.jupyter/tmp.py >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py && rm /home/$NB_USER/.jupyter/tmp.py

ENV GOPATH /home/$NB_USER/go
ENV GOROOT /usr/local/go/
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

# Install gen3-fuse
RUN apt-get update && apt-get install -y --no-install-recommends curl tar fuse \
  && curl -O https://dl.google.com/go/go1.12.linux-amd64.tar.gz \
  && tar -C /usr/local -xzf go1.12.linux-amd64.tar.gz \
  && export PATH=$PATH:/usr/local/go/bin \
  && mkdir $GOPATH && cd $GOPATH && mkdir src && cd src \
  && git clone https://github.com/uc-cdis/gen3-fuse.git \
  && cd gen3-fuse/ && ./build.sh && chmod 777 gen3fuse \
  && mv gen3fuse /usr/local/bin/gen3fuse \
  && mv config.yaml /home/$NB_USER/fuse-config.yaml \
  && export PATH=$PATH:/usr/local/bin/gen3fuse \
  && echo "export PATH=$PATH:/usr/local/bin/gen3fuse" >> /home/$NB_USER/.bashrc \
  && rm  -rf $GOPATH && rm /home/$NB_USER/go1.12.linux-amd64.tar.gz \
  && apt-get remove -y curl \
  && rm -rf /var/lib/apt/lists/*

ADD workspace_tools /home/$NB_USER/workspace_tools

USER $NB_USER
