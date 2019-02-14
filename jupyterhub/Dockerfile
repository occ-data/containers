FROM python:3.6-jessie

RUN apt-get update && \
    apt-get install -y npm nodejs-legacy && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g configurable-http-proxy && \
    pip3 install --no-cache-dir \
                 notebook \
                 jupyterhub-kubespawner==0.9.* \
                 git+https://github.com/jupyterhub/jupyterhub.git@7c46fe74a50da4badc332ef671954e2fac406757 \
                 git+https://github.com/occ-data/jhub_remote_user_authenticator.git@03899b8de6ba30ec33476997047c7e5013a42dd4 \
                 pycurl==7.43.0.1

ADD cull_idle_servers.py /usr/local/bin/cull_idle_servers.py

ENTRYPOINT jupyterhub
