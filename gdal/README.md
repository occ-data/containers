Geospatial Data Abstraction Library (GDAL) Container
===

# About
This container builds GDAL from the current github source along with the HDF5 & NetCDF libraries.

# Usage
Start a GDAL container image pulling from the quay.io library and mounting the current working directory as /data inside the container
```
docker run -d -ti -name=gdal -v $(pwd):/data quay.io/occ-data/gdal
```


# Building
To build the container do
```
docker build -t gdal .
```

If you are building this container on OSDC Griffin you will need to add the proxy
```
docker build --build-arg http_proxy=http://cloud-proxy:3128 --build-arg https_proxy=http://cloud-proxy:3128 -t gdal .
```
