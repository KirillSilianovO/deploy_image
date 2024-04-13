FROM --platform=${BUILDPLATFORM} python:3.12-alpine3.19

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
      ; \
    apk add --nocache --no-progress --virtual .build-dependencies \
      gcc \
      musl-dev \
      libffi-dev \
      python3-dev \
      ; \
    pip install --upgrade pip ;\
    pip install -r ./requirements.txt ;\
    ansible-galaxy collection install \
      community.postgresql \
      community.docker \
      community.mysql \
      community.network  \
      ; \
    apk del .build-dependencies
