GrADS Docker Container
===

Builds GrADS version 2.1.1.b0 in an Alpine based docker container

## Building the Dockerfile
To build the dockerfile run
```
docker build -t grads .
```
in the folder with the file.

## Running GrADS
First we need some example data, grab your favorite grib2 output from a NWP model. If you don't have one handy, you can download one from NOMADS for GFS at [ftp://ftpprd.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/](ftp://ftpprd.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/)

Build the dockerfile using the step above, or pull from the Quay.io registry
```
docker pull quay.io/occ_data/grads
```

Run the container mounting the directory with your grib file to /data
```
docker run -v $(pwd):/data --name grads -d --rm -ti grads
```

Finally here is an example of how to use GrADS to generate a geotiff file of the 2-m temperature. This example uses a GFS grib2 file called gfs.t12z.pgrb2.0p25.f003.
```
# Generate the grib control file
docker exec -ti grads g2ctl gfs.t12z.pgrb2.0p25.f003 >gfs.t12z.pgrb2.0p25.f003.ctl

# Generate the grib index file
docker exec -ti grads gribmap -i gfs.t12z.pgrb2.0p25.f003.ctl

# Run GrADS
docker exec -ti grads grads -lb
>open fs.t12z.pgrb2.0p25.f003.ctl
>set gxout geotiff
>d tmp2m
>quit
```

This should have saved a geotiff called gradsgeo.tif which you can then plot with your favorite GIS software to produce something like this.
![Example 2-m Temperature Output](/2m-temp.png?raw=true "Example 2-m Temperature Output")
