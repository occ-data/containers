FROM centos:6
LABEL maintainer "Zac Flamig <zflamig@uchicago.edu>"

COPY . /installfiles
WORKDIR /installfiles
RUN groupadd -r fxalpha \
	&& useradd --no-log-init -r -g fxalpha awips \
	&& yum install -y epel-release \
	&& yum update -y && yum install -y \
	apr-util-ldap \
	bc \
	boost \
	compat-libf2c-34 \
	csh \
	gcc-gfortran \
	gtk+-devel \
	gtk2-devel \
	httpd-tools \
	initscripts \
	libstdc++.i686 \
	log4j \
	mailcap \
	mesa-utils \
	mesa-libGL-devel \
	netcdf-devel \
	openmotif \
	pcre \
	system-logos \
	unzip \
	wget \
	wxGTK \
	wxGTK-devel \
	zenity \
	zlib \
	zlib.i686 \
	&& yum clean all \
	&& chmod +x ./installCAVE.sh \
	&& ./installCAVE.sh \
	&& cd \
	&& rm -rf /installfiles \
	&& mkdir /home/awips \
	&& chown awips:fxalpha /home/awips \
	&& mkdir -p /local/cave-eclipse \
	&& chown awips:fxalpha /local/cave-eclipse
WORKDIR /awips2
USER awips
CMD (/awips2/alertviz/alertviz.sh &) && (/awips2/cave/cave.sh)

