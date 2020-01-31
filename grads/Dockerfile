FROM multiarch/alpine:x86-v3.5
LABEL maintainer "Zac Flamig <zflamig@uchicago.edu>"

RUN apk --no-cache add \
	autoconf \
        automake \
        libtool \
	ca-certificates \
	cairo-dev \
	cmake \
	bison \
        gfortran \
        perl-dev \
	curl \
	expat-dev \
	freetype-dev \
	g++ \
	gcc \
	gd \
	jasper-dev \
	jpeg \
	libstdc++ \
	libx11-dev \
        libxmu-dev \
	libxpm-dev \
        libxaw-dev \
        libxml2-dev \
	m4 \
	make \
	musl-dev \
	ncurses-dev \
	perl \
	readline \
	tiff-dev \
	wget \
	zlib-dev

RUN apk --no-cache add \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        proj4-dev

# szip
RUN wget https://support.hdfgroup.org/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz \
        && tar xf szip-2.1.1.tar.gz \
        && cd szip-2.1.1 \
        && ./configure --prefix=/usr \
        && make -j4 \
        && make install \
        && cd .. \
        && rm -rf szip-2.1.1 szip-2.1.1.tar.gz

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

WORKDIR /grads
RUN wget ftp://cola.gmu.edu/grads/2.1/grads-2.1.1.b0-src.tar.gz \
	&& tar xf grads-2.1.1.b0-src.tar.gz

# Readline Installation
RUN wget http://git.savannah.gnu.org/cgit/readline.git/snapshot/readline-master.tar.gz \
	&& tar xf readline-master.tar.gz \
	&& cd readline-master \
	&& ./configure --prefix=/usr \
	&& make -j4 \
	&& make install \
	&& cd .. \
	&& rm -rf readline-master \
	&& rm -rf readline-master.tar.gz

# Geotiff
RUN wget http://download.osgeo.org/geotiff/libgeotiff/libgeotiff-1.4.2.tar.gz \
	&& tar xf libgeotiff-1.4.2.tar.gz \
	&& cd libgeotiff-1.4.2 \
	&& ./configure --prefix=/usr \
        && make -j4 \
        && make install \
        && cd .. \
        && rm -rf libgeotiff-1.4.2.tar.gz libgeotiff-1.4.2

# udunits
RUN wget ftp://ftp.unidata.ucar.edu/pub/udunits/udunits-1.12.11.tar.gz \
	&& tar xf udunits-1.12.11.tar.gz \
	&& cd udunits-1.12.11/src \
	&& export CPPFLAGS="-Df2cFortran -fPIC" \
	&& ./configure --prefix=/usr \
        && make \
        && make install \
        && cd ../.. \
        && rm -rf udunits-1.12.11 udunits-1.12.11.tar.gz

RUN wget http://www.nco.ncep.noaa.gov/pmb/codes/GRIB2/g2clib-1.6.0.tar \
	&& tar xf g2clib-1.6.0.tar \
	&& cd g2clib-1.6.0 \
	&& sed -i.bak -e "s/CFLAGS= -O3 -g -m64 \$(INC) \$(DEFS) -D__64BIT__/CFLAGS= -O3 -g \$(INC) \$(DEFS)/g" makefile \
	&& make \
	&& cp libg2c_v1.6.0.a /usr/lib/libgrib2c.a \
	&& cp grib2.h /usr/include \
	&& cd .. \
	&& rm -rf g2clib-1.6.0 g2clib-1.6.0.tar

RUN wget ftp://ftp-osl.osuosl.org/pub/libpng/src/libpng12/libpng-1.2.59.tar.gz \
	&& tar xf libpng-1.2.59.tar.gz \
	&& cd libpng-1.2.59 \
	&& ./configure --prefix=/usr \
	&& make \
        && make install \
        && cd .. \
        && rm -rf libpng-1.2.59 libpng-1.2.59.tar.gz

RUN wget https://github.com/libgd/libgd/archive/gd-2.2.4.tar.gz \
	&& tar xf gd-2.2.4.tar.gz \
	&& cd libgd-gd-2.2.4 \
	&& ./bootstrap.sh \
	&& ./configure --prefix=/usr \
        && make \
        && make install \
        && cd .. \
        && rm -rf gd-2.2.4.tar.gz libgd-gd-2.2.4

RUN wget ftp://ftp-osl.osuosl.org/pub/libpng/src/libpng15/libpng-1.5.30.tar.gz \
        && tar xf libpng-1.5.30.tar.gz \
        && cd libpng-1.5.30 \
        && ./configure --prefix=/usr \
        && make \
        && make install \
        && cd .. \
        && rm -rf libpng-1.5.30 libpng-1.5.30.tar.gz

RUN wget http://download.osgeo.org/shapelib/shapelib-1.4.0.tar.gz \
        && tar xf shapelib-1.4.0.tar.gz \
        && cd shapelib-1.4.0 \
        && ./configure --prefix=/usr \
        && make \
        && make install \
        && cd .. \
        && rm -rf shapelib-1.4.0 shapelib-1.4.0.tar.gz

RUN export SUPPLIBS=$HOME/supplibs && mkdir -p $HOME/supplibs/lib && mkdir -p $HOME/supplibs/include \
	&& ln -sf /lib/* $HOME/supplibs/lib/. \
	&& ln -sf /include/* $HOME/supplibs/include/. \
	&& ln -sf /usr/lib/* $HOME/supplibs/lib/. \
        && ln -sf /usr/include/* $HOME/supplibs/include/. \
	&& cd grads-2.1.1.b0 \
	&& sed -i.bak -e "s/SET_LIB_VAR/SET_DYNLIB_VAR/g" configure.ac \
	&& autoreconf -i \
	&& ./configure --prefix=/usr \
	&& make \
	&& make install \
	&& cd .. \
	&& rm -rf grads-2.1.1.b0 grads-2.1.1.b0-src.tar.gz

RUN wget ftp://cola.gmu.edu/grads/data2.tar.gz \
	&& mkdir -p /usr/local/lib/grads \
	&& tar -xC /usr/local/lib/grads -f data2.tar.gz \
	&& rm -f data2.tar.gz

# g2ctl & wgrib for processing grib files
RUN wget ftp://ftp.cpc.ncep.noaa.gov/wd51we/g2ctl/g2ctl \
        && mv g2ctl /usr/bin/g2ctl \
        && chmod +x /usr/bin/g2ctl \
	&& wget http://www.ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/wgrib2.tgz.v2.0.6c \
        && tar -zxvf wgrib2.tgz.v2.0.6c \
        && cd grib2 \
        && export CC=gcc \
        && export FC=gfortran \
        && make \
        && cp wgrib2/wgrib2 /usr/bin/ \
        && cd .. \
        && rm -rf grib2 \
        && rm -f wgrib2.tgz.v2.0.6c

WORKDIR /data
CMD /bin/sh
