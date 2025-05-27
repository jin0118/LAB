#! /bin/sh
rm -rf tls.*
kubectl delete secret my-tls-secret

DOMAIN="rancher.jindol.com"

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=$DOMAIN/O=$DOMAIN"

kubectl create secret tls my-tls-secret \
--cert=tls.crt \
--key=tls.key

kubectl apply -f nginx-controller.yaml --validate=false