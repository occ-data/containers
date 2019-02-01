docker build -t brainlife/freesurfer . && \
    docker tag brainlife/freesurfer brainlife/freesurfer:6.0.0 && \
    docker push brainlife/freesurfer
