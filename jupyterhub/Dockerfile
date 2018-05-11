FROM python:3.6

RUN apt-get update && \
    apt-get install -y npm nodejs-legacy

RUN npm install -g configurable-http-proxy && \
    pip3 install --no-cache-dir \
                 notebook \
                 jupyterhub==0.8.* \
                 https://github.com/jupyterhub/kubespawner/archive/6d5993c.tar.gz \
                 jhub_remote_user_authenticator \
                 pycurl==7.43.0.1

ADD cull_idle_servers.py /usr/local/bin/cull_idle_servers.py

ENTRYPOINT jupyterhub
