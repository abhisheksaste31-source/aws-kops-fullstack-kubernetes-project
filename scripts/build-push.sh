#!/bin/bash
# Usage: ./scripts/build-push.sh <dockerhub-username> [tag]
set -e
USER=${1:?Usage: $0 <dockerhub-username> [tag]}
TAG=${2:-v1}
docker build -t $USER/backend:$TAG  ./backend
docker build -t $USER/frontend:$TAG ./frontend
docker login
docker push $USER/backend:$TAG
docker push $USER/frontend:$TAG
echo "Now update image: in k8s/backend-deployment.yml and k8s/frontend-deployment.yml to $USER/*:$TAG"
