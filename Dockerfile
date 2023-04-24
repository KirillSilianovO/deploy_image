ARG BUILDPLATFORM
ARG TARGETPLATFORM

FROM --platform=${BUILDPLATFORM} ${TARGETPLATFORM}/python:3.11-alpine

RUN /bin/sh -c set -eux; \
    apk add --no-cache --no-progress  \
      git \
      openssh-client \
      rsync \
      ; \
    apk add --nocache --no-progress --virtual .build-dependencies \
      git \
      gcc \
      musl-dev \
      libffi-dev \
      python3-dev \
      ; \
    pip install \
      ansible \
      paramiko \
      ansible-lint \
      molecule \
      ansible-core; \
    ansible-galaxy collection install \
      community.postgresql \
      community.docker \
      community.mysql \
      community.network  \
      ; \
    apk del .build-dependencies

WORKDIR /workdir