#!/bin/bash
export HUB_APP_NAME="opencv"
export HUB_INGRESS_HOST="app.anton1.antondemo0101.dev.superhub.io"
export HUB_DOCKER_HOST="dock-harbor.app.anton1.antondemo0101.dev.superhub.io"
export HUB_DOCKER_USER="admin"
export HUB_DOCKER_PASS="password"
export SKAFFOLD_DEFAULT_REPO="$HUB_DOCKER_HOST/library"
