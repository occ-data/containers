FROM python:3.6-jessie

RUN apt-get update && \
    apt-get install -y npm nodejs-legacy && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g configurable-http-proxy && \
    pip3 install --no-cache-dir \
                 notebook \
                 jupyterhub==0.9.* \
                 jupyterhub-kubespawner==0.9.* \
                 git+https://github.com/occ-data/jhub_remote_user_authenticator.git@c942e51d3efb04492d72be14b7b1e1ef4cfa3df2 \
                 pycurl==7.43.0.1

ADD cull_idle_servers.py /usr/local/bin/cull_idle_servers.py

ENTRYPOINT jupyterhub
