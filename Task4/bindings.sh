#!/bin/bash

# admin
kubectl apply -f - <<EOF
kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: admin-binding
subjects:
- kind: User
  name: admin
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: admin-role
  apiGroup: rbac.authorization.k8s.io
EOF

# developer
kubectl apply -f - <<EOF
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: developer-binding
  namespace: app-namespace
subjects:
- kind: User
  name: developer
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: developer-role
  apiGroup: rbac.authorization.k8s.io
EOF

# viewer
kubectl apply -f - <<EOF
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: viewer-binding
  namespace: app-namespace
subjects:
- kind: User
  name: viewer
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: viewer-role
  apiGroup: rbac.authorization.k8s.io
EOF

# secret-manager
kubectl apply -f - <<EOF
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: secret-manager-binding
  namespace: app-namespace
subjects:
- kind: User
  name: secret-manager
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: secret-manager-role
  apiGroup: rbac.authorization.k8s.io
EOF