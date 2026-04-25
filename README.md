# Deploy Image ##

## Description ##

Docker image for deploying the application

## Contains ##

- Ansible
- Git
- Rsync

### Ansible collections ###
- ansible.netcommon
- community.docker
- community.routeros
- community.crypto
- community.general

### Ansible roles ###
  - [Docker](https://github.com/KirillSilianovO/ansible_role_docker)
  - [Traefik](https://github.com/KirillSilianovO/ansible_role_traefik)

## Build ##

### Dependencies ###

- docker
- docker-bake
- taskfile

### Prepare ###

Copy example.secrets.yaml to .secrets.yaml and fill in the values

### Build image and load to local docker###

```shell
task build_load
```

### Build multi-arch image and push to registry ###

```shell
task build_push_global
```