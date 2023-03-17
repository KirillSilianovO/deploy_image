FROM --platform=$BUILDPLATFORM debian:11.6-slim

RUN set -eux; \
    apt-get update; \
    apt-get install -y  \
      openssh-client \
      rsync \
      curl \
      python3 \
      python3-pip; \
    python3 -m pip install ansible; \
    python3 -m pip install paramiko; \
    ansible-galaxy collection install \
        community.postgresql \
        community.docker \
        community.mysql \
        community.network