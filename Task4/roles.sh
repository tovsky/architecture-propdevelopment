#!/bin/bash

kubectl create namespace app-namespace

kubectl apply -f - <<EOF
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: admin-role
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
EOF

kubectl apply -f - <<EOF
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: app-namespace
  name: developer-role
rules:
- apiGroups: ["", "apps", "extensions"]
  resources: ["deployments", "pods", "services"]
  verbs: ["create", "get", "list", "watch", "update", "patch", "delete"]
EOF

kubectl apply -f - <<EOF
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: app-namespace
  name: viewer-role
rules:
- apiGroups: ["", "apps", "extensions"]
  resources: ["*"]
  verbs: ["get", "list", "watch"]
EOF

kubectl apply -f - <<EOF
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: app-namespace
  name: secret-manager-role
rules:
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["*"]
EOF