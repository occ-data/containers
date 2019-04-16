# TL;DR

Jupyter notebook with freesurfer installed.

## Notes

Freesurfer is big (11 Gig), so this docker image is big, so the `quay` build fails,
so we for now just build locally, tag, and push to quay.io/cdis/jupyterbrain
