# Deploying nginx using ARGOCD CI with a valid SSL certificate.
***
We need to configure our github repositry on Argocd and then create an applicaton using argoCD.
***
Important step to configure argoCD repo, and create an application:
- Give the path of your github repository where are the files stored.
- Each time that you make a push from local your argocd will sync your repo
- Need to have an DNS name, and we should use our service ingres-controller IPS and attach them to DNS, not the ClusterIps, its up to controller and according to dns to choose the right path.
- 