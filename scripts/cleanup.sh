#!/bin/bash
kubectl delete -f k8s/ingress.yml --ignore-not-found
kubectl delete namespace production --ignore-not-found
echo "To remove the ingress controller too: kubectl delete ns ingress-nginx"
