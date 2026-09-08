#!/bin/bash
set -e

echo "1. Applying aws-auth ConfigMap to link worker nodes..."
cat << 'EOF' | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: arn:aws:iam::803525118502:role/udacity-node-group
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
  mapUsers: |
    - userarn: arn:aws:iam::803525118502:user/github-action-user
      username: github-action-role
      groups:
        - system:masters
EOF

echo ""
echo "2. Waiting 10 seconds for node registration..."
sleep 10

echo ""
echo "=========================================="
echo ">> KUBECTL GET NODES <<"
echo "=========================================="
kubectl get nodes

echo ""
echo "=========================================="
echo ">> KUBECTL GET PODS -O WIDE <<"
echo "=========================================="
kubectl get pods -o wide