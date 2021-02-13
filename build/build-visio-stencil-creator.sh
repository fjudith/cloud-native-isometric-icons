#!/bin/bash

GITHUB_ORG="hoveytechllc"
REPO_NAME="visio-stencil-creator"
TAG_NAME="v1.0"

GCR_REPO="staging-k8s.gcr.io/${REPO_NAME}:${TAG_NAME}"

rm -fdr ./build/${REPO_NAME}

# Clone repository in current path
git clone --branch release/${TAG_NAME} https://github.com/${GITHUB_ORG}/${REPO_NAME}.git ./build/${REPO_NAME}

# build/ image using Dockerfile from github repository
# Tag resulting image for pushing
docker build/ \
    -t ${GCR_REPO} \
    -f ./build/${REPO_NAME}/Dockerfile \
    ./build/${REPO_NAME}

# Clean up source code
rm -fdr ./build/${REPO_NAME}

docker push ${GCR_REPO}