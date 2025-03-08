# Deploy Image ##

## Description ##

Docker image for deploying the application

## Contains ##

- Ansible
- Git
- Helm
- Rsync

## Build ##

### Dependencies ###

- docker
- docker-bake
- taskfile

### Prepare ###

Copy example.secrets.yaml to .secrets.yaml and fill in the values

### Build local image ###

```shell
task build_load
```

### Build multi-arch image and push to registry ###

```shell
task build_push_global
```