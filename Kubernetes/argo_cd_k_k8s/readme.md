

## issuer and ingress should be deployed in same name space: argocd
### Install argoCD on your Cluster

`kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
`

## Ngenix controller to get external ips
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/cloud/deploy.yaml`

### To get secret password for argocd stored in secred we need to use base64 to decode it.
## `echo WDJsZTlUQldXckRuRnZXQg== | base64 -d`



