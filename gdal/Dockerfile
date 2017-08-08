FROM alpine:3.5

LABEL maintainer "Zac Flamig <zflamig@uchicago.edu>"

RUN apk --no-cache add \
        build-base \
        ca-certificates \
        git \
        jasper-dev \
	linux-headers \
	m4 \
        wget \
        zlib-dev

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
        && rm -rf hdf5-1.10.1.tar.bz2

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

# GDAL Installation
RUN git clone https://github.com/OSGeo/gdal.git /gdalgit \
        && cd /gdalgit/gdal \
        && ./configure --prefix=/usr \
        && make -j4 \
        && make install \
	&& cd / \
	&& rm -rf gdalgit

WORKDIR /data
CMD /bin/sh
