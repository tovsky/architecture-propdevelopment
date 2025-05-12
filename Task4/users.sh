#!/bin/bash

openssl genrsa -out admin.key 2048
openssl genrsa -out developer.key 2048
openssl genrsa -out viewer.key 2048
openssl genrsa -out secret-manager.key 2048

openssl req -new -key admin.key -out admin.csr -subj "/CN=admin/O=devops"
openssl req -new -key developer.key -out developer.csr -subj "/CN=developer/O=developers"
openssl req -new -key viewer.key -out viewer.csr -subj "/CN=viewer/O=viewers"
openssl req -new -key secret-manager.key -out secret-manager.csr -subj "/CN=secret-manager/O=security"

openssl x509 -req -in admin.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out admin.crt -days 365
openssl x509 -req -in developer.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out developer.crt -days 365
openssl x509 -req -in viewer.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out viewer.crt -days 365
openssl x509 -req -in secret-manager.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out secret-manager.crt -days 365

kubectl config set-credentials admin --client-certificate=admin.crt --client-key=admin.key
kubectl config set-credentials developer --client-certificate=developer.crt --client-key=developer.key
kubectl config set-credentials viewer --client-certificate=viewer.crt --client-key=viewer.key
kubectl config set-credentials secret-manager --client-certificate=secret-manager.crt --client-key=secret-manager.key

kubectl config set-context admin-context --cluster=minikube --user=admin
kubectl config set-context developer-context --cluster=minikube --user=developer
kubectl config set-context viewer-context --cluster=minikube --user=viewer
kubectl config set-context secret-manager-context --cluster=minikube --user=secret-manager