#!/bin/bash
set -e
kubectl apply -f k8s/namespace.yml
kubectl apply -f k8s/configmap.yml
kubectl apply -f k8s/secret.yml
kubectl apply -f k8s/mysql-init-configmap.yml
kubectl apply -f k8s/mysql-headless.yml
kubectl apply -f k8s/mysql-statefulset.yml
kubectl apply -f k8s/backend-deployment.yml
kubectl apply -f k8s/backend-service.yml
kubectl apply -f k8s/frontend-deployment.yml
kubectl apply -f k8s/frontend-service.yml
# Ingress controller (skipped if already installed)
kubectl get ns ingress-nginx >/dev/null 2>&1 || \
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
echo "Waiting for ingress controller..."
kubectl wait --namespace ingress-nginx --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller --timeout=180s
kubectl apply -f k8s/ingress.yml
kubectl get pods -n production
kubectl get svc -n ingress-nginx
