FROM --platform=${BUILDPLATFORM} python:3.13-alpine3.21

WORKDIR /workdir

COPY requirements.txt /workdir/

RUN /bin/sh -c set -eux; \
    apk update ;\
    apk add --no-cache --no-progress  \
      git \
      openssh-client \
      rsync \
      sshpass \
      helm \
      curl \
      wget \
      ; \
    apk add --nocache --no-progress --virtual .build-dependencies \
      gcc \
      musl-dev \
      libffi-dev \
      python3-dev \
      libssh-dev \
      ; \
    pip install --upgrade pip setuptools wheel ;\
    pip install -r ./requirements.txt ;\
    apk del .build-dependencies
