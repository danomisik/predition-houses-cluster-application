#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# Create dockerpath
dockerpath=danielmisik/udacity

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run ml-service-kubectl --image=$dockerpath:ml-service  --port=80 --env="DOMAIN=cluster"

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward deployment/ml-service-kubectl 8000:80
