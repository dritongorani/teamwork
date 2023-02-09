# Installation of ARGOCD on CLuster K8S, Ngenix ingress controller, and configuring an SSL certificate using lets Encrpyt.

## issuer and ingress should be deployed in same name space: argocd

### Install argoCD on your Cluster
### Link to install argoCD from repo directely, just need to create a namespace before.
`kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
`

## Ngenix controller to get external ips, very important step because it's up to this service to dispatch the right way of request according to DNS. We need to use it's IPS to configure DNS and not CLUSTER IPS, Ngenix-Controller IPS for DNS.
`kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.5.1/deploy/static/provider/cloud/deploy.yaml`

### To get secret password for argocd stored in secred we need to use base64 to decode it.
## `echo WDJsZTlUQldXckRuRnZXQg== | base64 -d`



