FROM debian:11.5-slim

LABEL version="0.10"
LABEL description="Deploy image"

RUN set -eux; \
    apt-get update; \
    apt-get install -y  \
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