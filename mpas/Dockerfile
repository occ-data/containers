FROM centos:latest
LABEL maintainer "Zac Flamig <zflamig@uchicago.edu>"

RUN yum -y update \
	&& yum -y install \
	bzip2 \
	cmake \
	file \
	gcc \
	gcc-c++ \
	git \
	glibc.i686 \
	hostname \
	libgcc.i686 \
	libpng-devel \
	jasper \
	jasper-devel \
	m4 \
	make \
	net-tools \
	openssh-clients \
        openssh-server \
	perl \
	tar \
	tcsh \
	time \
	wget \
	which \
	zlib \
	zlib-devel \
	&& yum clean all

ENV LD_LIBRARY_PATH=/usr/lib64/openmpi/lib PATH=/usr/lib64/openmpi/bin:$PATH CFLAGS=-I/usr/local/io/include FFLAGS=-I/usr/local/io/include LDFLAGS=-L/usr/local/io/lib NETCDF_PATH=/usr/local/io NETCDF=/usr/local/io PNETCDF=/usr/local/io PIO=/usr/local/io PNETCDF_PATH=/usr/local/io JASPERINC=/usr/include/jasper/ JASPERLIB=/usr/lib64/

ENV MPAS_VERSION=5.2 GCC_VERSION=7.1.0 GMP_VERSION=6.1.0 MPC_VERSION=1.0.3 MPFR_VERSION=3.1.5 MPICH_VERSION=3.2 NETCDFC_VERSION=4.4.1.1 NETCDFFORTRAN_VERSION=4.4.4 PNETCDF_VERSION=1.8.1 PIO_VERSION=1_7_2

# Download GCC & necessary components, compile, and install
RUN wget --no-verbose http://ftpmirror.gnu.org/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.bz2 \
	&& tar xf gcc-${GCC_VERSION}.tar.bz2 \
	&& rm gcc-${GCC_VERSION}.tar.bz2 \
	&& wget --no-verbose https://gmplib.org/download/gmp/gmp-${GMP_VERSION}.tar.xz \
	&& tar xf gmp-${GMP_VERSION}.tar.xz \
	&& mv gmp-${GMP_VERSION} gcc-${GCC_VERSION}/gmp \
	&& rm gmp-${GMP_VERSION}.tar.xz \
	&& wget --no-verbose ftp://ftp.gnu.org/gnu/mpc/mpc-${MPC_VERSION}.tar.gz \
	&& tar xf mpc-${MPC_VERSION}.tar.gz \
	&& mv mpc-${MPC_VERSION} gcc-${GCC_VERSION}/mpc \
	&& rm mpc-${MPC_VERSION}.tar.gz \
	&& wget --no-verbose http://www.mpfr.org/mpfr-current/mpfr-${MPFR_VERSION}.tar.xz \
	&& tar xf mpfr-${MPFR_VERSION}.tar.xz \
	&& mv mpfr-${MPFR_VERSION} gcc-${GCC_VERSION}/mpfr \
	&& rm mpfr-${MPFR_VERSION}.tar.xz \
	&& mkdir gcc-${GCC_VERSION}_build \
	&& cd gcc-${GCC_VERSION}_build \
	&& ../gcc-${GCC_VERSION}/configure \
        	--prefix=/usr \
        	--disable-multilib \
        	--enable-languages=c,c++,fortran \
        	--enable-libstdcxx-threads \
        	--enable-libstdcxx-time \
        	--enable-shared \
        	--enable-__cxa_atexit \
        	--disable-libunwind-exceptions \
        	--disable-libada \
		--disable-libcc1 \
        	--host x86_64-redhat-linux-gnu \
        	--build x86_64-redhat-linux-gnu \
        	--with-default-libstdcxx-abi=gcc4-compatible \
	&& make -j4 \
	&& make install \
	&& cd .. \
	&& rm -rf gcc-${GCC_VERSION}_build gcc-${GCC_VERSION} \
# 	OpenMPI
	&& wget http://www.mpich.org/static/downloads/${MPICH_VERSION}/mpich-${MPICH_VERSION}.tar.gz \
	&& tar xf mpich-${MPICH_VERSION}.tar.gz \
	&& rm mpich-${MPICH_VERSION}.tar.gz \
	&& cd mpich-${MPICH_VERSION} \
	&& ./configure \
	&& make -j4 \
	&& make install \
	&& cd .. \
	&& rm -rf mpich-${MPICH_VERSION} \
# 	NetCDF-C
	&& wget https://github.com/Unidata/netcdf-c/archive/v${NETCDFC_VERSION}.tar.gz \
	&& tar xf v${NETCDFC_VERSION}.tar.gz \
	&& rm v${NETCDFC_VERSION}.tar.gz \
	&& mkdir /usr/local/io \
	&& cd netcdf-c-${NETCDFC_VERSION} \
	&& ./configure --prefix=/usr/local/io --disable-shared --disable-netcdf-4 --disable-dap --disable-utilities \
	&& make -j4 \
	&& make install \
	&& cd .. \
	&& rm -rf netcdf-c-${NETCDFC_VERSION} \
# 	NetCDF-Fortran
	&& wget https://github.com/Unidata/netcdf-fortran/archive/v${NETCDFFORTRAN_VERSION}.tar.gz \
        && tar xf v${NETCDFFORTRAN_VERSION}.tar.gz \
	&& rm v${NETCDFFORTRAN_VERSION}.tar.gz \
        && cd netcdf-fortran-${NETCDFFORTRAN_VERSION} \
	&& ./configure --prefix /usr/local/io --disable-shared \
	&& make -j4 \
	&& make install \
	&& cd .. \
	&& rm -rf netcdf-fortran-${NETCDFFORTRAN_VERSION} \
# 	NetCDF-Parallel
	&& wget http://cucis.ece.northwestern.edu/projects/PnetCDF/Release/parallel-netcdf-${PNETCDF_VERSION}.tar.gz \
        && tar xf parallel-netcdf-${PNETCDF_VERSION}.tar.gz \
	&& rm parallel-netcdf-${PNETCDF_VERSION}.tar.gz \
        && cd parallel-netcdf-${PNETCDF_VERSION} \
	&& ./configure --prefix /usr/local/io --disable-cxx \
	&& make -j4 \
	&& make install \
	&& cd .. \
	&& rm -rf parallel-netcdf-${PNETCDF_VERSION} \
#	PIO
	&& wget https://github.com/NCAR/ParallelIO/archive/pio${PIO_VERSION}.tar.gz \
	&& tar xf pio${PIO_VERSION}.tar.gz \
	&& rm pio${PIO_VERSION}.tar.gz \
	&& cd ParallelIO-pio${PIO_VERSION}/pio \
	&& ./configure --prefix=/usr/local/io \
	&& make \
	&& make install \
	&& cd ../.. \
	&& rm -rf ParallelIO-pio${PIO_VERSION}

# Actually get & compile MPAS here
WORKDIR /mpas
RUN wget https://github.com/MPAS-Dev/MPAS-Release/archive/v${MPAS_VERSION}.tar.gz \
	&& tar xf v${MPAS_VERSION}.tar.gz \
	&& cd MPAS-Release-${MPAS_VERSION} \
	&& sed -i.bak -e 's/NF_FILL_INT/nf90_fill_int/g' src/framework/mpas_io.F \
	&& sed -i.bak -e 's/achar(NF_FILL_CHAR)/nf90_fill_char/g' src/framework/mpas_io.F \
	&& sed -i.bak -e 's/NF_FILL_DOUBLE/nf90_fill_double/g' src/framework/mpas_io.F \
	&& sed -i.bak -e 's/PIO_64BIT_DATA/16/g' src/framework/mpas_io.F \
	&& make gfortran CORE=init_atmosphere \
	&& make clean CORE=atmosphere \
	&& make gfortran CORE=atmosphere

CMD /bin/bash
