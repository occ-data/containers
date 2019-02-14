FROM python:3.7-stretch

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && \
    apt-get install -y git bzip2 nodejs && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g configurable-http-proxy && \
    pip3 install --no-cache-dir \
                 notebook \
                 jupyterhub-kubespawner==0.9.* \
                 git+https://github.com/jupyterhub/jupyterhub.git@dcdb8d8a89d98cda411f00ac92b99f008ffaefd6 \
                 git+https://github.com/occ-data/jhub_remote_user_authenticator.git@4061723f21718577d0b8b6c129f82745f44c42b6 \
                 pycurl==7.43.0.1

ADD cull_idle_servers.py /usr/local/bin/cull_idle_servers.py

ENTRYPOINT jupyterhub
