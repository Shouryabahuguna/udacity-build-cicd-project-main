#!/bin/bash
set -e

# 1. Check & Prompt for AWS Keys if missing
if [ -z "$AWS_ACCESS_KEY_ID" ]; then
    echo "=== AWS Credentials Missing in Terminal Session ==="
    read -p "Enter AWS Access Key ID: " input_key
    read -s -p "Enter AWS Secret Access Key: " input_secret
    echo ""
    export AWS_ACCESS_KEY_ID="$input_key"
    export AWS_SECRET_ACCESS_KEY="$input_secret"
    export AWS_DEFAULT_REGION="us-east-1"
fi

echo "--- 1. Verifying AWS Identity ---"
aws sts get-caller-identity

echo "--- 2. Updating Kubeconfig ---"
aws eks update-kubeconfig --name cluster --region us-east-1

echo "--- 3. Writing aws-auth ConfigMap ---"
cat << 'EOF' > /tmp/aws-auth.yaml
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

echo "--- 4. Applying aws-auth (Validation Bypassed) ---"
kubectl apply --validate=false -f /tmp/aws-auth.yaml

echo "--- 5. Waiting 15 seconds for Node to Join ---"
sleep 15

echo "--- 6. Verifying Cluster Status ---"
kubectl get nodes
kubectl get pods