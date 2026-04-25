FROM --platform=${BUILDPLATFORM} python:3.14-slim-trixie

WORKDIR /workdir

COPY requirements.txt /workdir/
COPY requirements.yaml /workdir/

RUN apt-get update ;\
    apt-get upgrade -y ;\
    apt-get dist-upgrade -y ;\
    apt-get install -y  \
      git \
      openssh-client \
      rsync \
      sshpass \
      curl \
      wget ; \
    apt-get install -y \
      gcc \
      musl-dev \
      libffi-dev \
      python3-dev \
      libssh-dev \
      ; \
    pip install --upgrade pip setuptools wheel ;\
    pip install -r ./requirements.txt ;\
    apt-get remove -y  \
      gcc  \
      musl-dev  \
      python3-dev  \
      libffi-dev  \
      ; \
    apt-get autoremove -y ;\
    apt-get clean ;\
    ansible-galaxy install -r requirements.yaml --force
