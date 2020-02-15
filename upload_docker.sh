#!/usr/bin/env bash

#Arguments for bash script
DOCKER_USER=$1
DOCKER_PASS=$2


# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
 dockerpath=danielmisik/udacity

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker login --username=$DOCKER_USER --password=$DOCKER_PASS $DOCKER_HOST
docker tag ml-service $dockerpath:ml-service

# Step 3:
# Push image to a docker repository
docker push $dockerpath:ml-service
