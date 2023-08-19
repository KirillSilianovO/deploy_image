FROM --platform=${BUILDPLATFORM} python:3.11-alpine3.18

WORKDIR /workdir

RUN /bin/sh -c set -eux; \
    apk add --no-cache --no-progress  \
      git \
      openssh-client \
      rsync \
      sshpass \
      ; \
    apk add --nocache --no-progress --virtual .build-dependencies \
      gcc \
      musl-dev \
      libffi-dev \
      python3-dev \
      ; \
    pip install --upgrade pip
COPY requirements.txt /workdir/
RUN pip install -r ./requirements.txt ;\
    ansible-galaxy collection install \
      community.postgresql \
      community.docker \
      community.mysql \
      community.network  \
      ; \
    apk del .build-dependencies

WORKDIR /workdir