FROM python:3.6

RUN apt-get update && \
    apt-get install -y npm nodejs-legacy

RUN npm install -g configurable-http-proxy && \
    pip3 install --no-cache-dir \
                 notebook \
                 jupyterhub==0.8.1 \
                 jupyterhub-kubespawner==0.7.1 \
                 jhub_remote_user_authenticator

ENTRYPOINT jupyterhub
