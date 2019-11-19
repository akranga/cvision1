#!/bin/bash

export DOMAIN_NAME="cluster1.antondemo01.dev.superhub.io"

export HUB_INGRESS_HOST="opencv.app.$DOMAIN_NAME"
export HUB_DOCKER_HOST="docker-harbor.app.$DOMAIN_NAME"

# export HUB_DOCKER_HOST="lotsa1-harbor-harbor-registry.harbor:5000"
export HUB_DOCKER_USER="admin"
export HUB_DOCKER_PASS="Harbor12345"
export SKAFFOLD_DEFAULT_REPO="$HUB_DOCKER_HOST/library"
