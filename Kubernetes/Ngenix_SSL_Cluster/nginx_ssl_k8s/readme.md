### SSL Kubernetes Cluster, lets encrypt procedure.

#### We are going to generate an SSL valid certificate by using let's encrpyt.

#### In order to do this we need: 

- Deployment file 
- Ingress
- Issuer
- Cert/manager installed

***Deployment*** file content all about the containers port, image, and our deployment service we need to specifiy if we use a LoadBalancer or Ingress in order to have external IPS for our POD.
ex:
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: dritonnginx
  namespace: driton 
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 1 
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: apache2
        image: httpd
        ports:
        - name: exposehttp
          containerPort: 80
          protocol: TCP
---
##Deployment service
apiVersion: v1
kind: Service
metadata:
  name: dritonservice
  namespace: driton
spec:
  # type: LoadBalancer
  selector:
    app: nginx
  ports:
    - name: httpd
      protocol: TCP
      port: 80
      targetPort: 80
```


***
***Ingress*** is an API object that provides routing rules to manage external users' access to the services in a Kubernetes cluster, typically via HTTPS/HTTP. With Ingress, you can easily set up rules for routing traffic without creating a bunch of Load Balancers or exposing each service on the node. 
- For our SSL certificate in ingress we need to configure `annotations` we need to put `cert-manager.io/issuer: name_of_your_issuer` and

 ```
tls:
    - hosts:
      - tonytest.sandbox.aws.teamwork.net
      secretName: drsecretcertificat
```
 - We need also to paste our ingress controller :
 ```
 ###Ingress controller
apiVersion: networking.k8s.io/v1
kind: IngressClass
metadata:
  name: nginx
spec:
  controller: k8s.io/ingress-nginx
  ```
 ***
 ### Issuer are Kubernetes resources that represent certificate authorities (CAs) that are able to generate signed certificates by honoring certificate signing requests ex:
 
 ```
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: letsencrypt-stagging
  namespace: driton
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: tony@gmail.com
    privateKeySecretRef:
      name: dritonprivate
    solvers:
    - http01:
        ingress:
          class: nginx
```
***

### Cert-manager adds certificates and certificate issuers as resource types in Kubernetes clusters, and simplifies the process of obtaining, renewing and using those certificates

Note: We can verify our certificate with our own isseur or clusster issuer, for security its better to use our own Issuer to verify these certs.