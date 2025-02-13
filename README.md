## Features
- Local ssd support with fast-disk storageClass
- Load balancer support
- Use Karpenter for auto scaling, no need to specify the auto scaling group, just specify the nodeSelector in the yaml

## Usage

```bash
# Setup AWS credential
# Install tofu
tofu init

# Show the resource planned
tofu plan

# Spin up the cluster
tofu apply --auto-approve

# Make sure you have updated your local kubeconfig
aws eks --region us-west-2 update-kubeconfig --name test-vchord

# Setup Karpernter with node requirements
kubectl apply -f karpenter.yaml

# Setup local ssd provisioner
kubectl apply -f provisioner_generated.yaml

# Setup the storage class
kubectl apply -f storageclass.yaml
```

!!!IMPORTANT!!! For destroy, follow the steps below to avoid any issues. Otherwise, the resources will be leaked and stuck in the terminating state.
```bash
# Delete all resources first (This will delete the resource like load balancer)
kubectl delete all --all
# Delete all nodes spawned by karpenter
kubectl delete node -l karpenter.sh/initialized=true
# Delete the whole cluster
tofu destroy
```