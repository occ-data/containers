AWIPS II Container
===

This container installs the visualization portion of the Advanced Weather Interactive Processing System II
(AWIPS 2).

The tarbar with the RPMs is currently not provided.

Build with
``
docker build -t awips2 .
```

Run as follows
```
xhost +
docker run --rm -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY --device /dev/dri -v /etc/fonts:/etc/fonts:ro -v /usr/share/fonts:/usr/share/fonts:ro -v /etc/hosts:/etc/hosts:ro -ti awips2
```
