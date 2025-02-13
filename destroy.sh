kubectl delete all --all
kubectl delete node -l karpenter.sh/initialized=true
tofu destroy
