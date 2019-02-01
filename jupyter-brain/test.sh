
#docker run -it --rm brainlife/freesurfer mri_convert testdata/test.nii.gz test.mgz

#export FREESURFER_LICENSE="~/.config/freesurfer.license.txt"
#singularity exec -e docker://brainlife/freesurfer bash -c "cp $FREESURFER_LICENSE /usr/local/freesurfer/license.txt && mri_convert testdata/t1.nii.gz test.mgz"

export FREESURFER_LICENSE="hayashis@iu.edu 29511 *CPmh9xvKQKHE FSg0ijTusqaQc"
singularity exec -e docker://brainlife/freesurfer:6.0.0 bash -c "echo $FREESURFER_LICENSE > /usr/local/freesurfer/license.txt && mri_convert testdata/t1.nii.gz test.mgz"
