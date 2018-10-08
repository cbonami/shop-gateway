# Shop Gateway

## GCE Ingress

Partially based on [this]()https://cloud.google.com/community/tutorials/nginx-ingress-gke).

Deploy tiller with RBAC enabled:

```
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'  
helm init --service-account tiller --upgrade
```

Deploy NGINX Controller with RBAC enabled:

```
helm install --name nginx-ingress stable/nginx-ingress --set rbac.create=true
```

## Travis

[Inspiration](http://thylong.com/ci/2016/deploying-from-travis-to-gce/)

Make a project on 

Make service account on GCP 
* Google Cloud Dashboard > IAM > Service Accounts > Add
Service Account Name: travisci
Roles:
* Project > Edit
* Storage Admin
Make note of sa's email: travisci@...

Or use commandline (I did not get this working yet):

```
gcloud projects add-iam-policy-binding shop -- member serviceAccount:travisci@refined-algebra-215620.iam.gserviceaccount.com -- role roles/storage.admin
```

Set some env variables needed by the Travis build (see .travis.yml > env.global.secure):

```
travis login --pro
travis encrypt GKE_USERNAME=cbonami@gmail.com --add --com
```

... and/or set the env vars via 'Travis project settings': 

* GCLOUD_EMAIL: travisci@refined-algebra-215620.iam.gserviceaccount.com
* CLOUDSDK_CORE_PROJECT: your gcloud project id; eg: refined-algebra-215620
* CLOUDSDK_COMPUTE_ZONE: europe-west1-b	
* GKE_SERVER: the cluster IP: eg: 35.205.224.241
* MICROSERVICE_NAME: shop-gateway

Base64 encoding:
```
cat project-shop-gateway.json | base64 > base64
```

> see pastebin.md for key

## Links

* [Spring Cloud Gateway - Baeldung](https://www.baeldung.com/spring-cloud-gateway)
* [Spring Cloud Gateway - Routing Example](https://stackoverflow.com/questions/48865174/spring-cloud-gateway-proxy-forward-the-entire-sub-part-of-url)
* [Deploying from Travis to GCE](http://thylong.com/ci/2016/deploying-from-travis-to-gce/)

https://stackoverflow.com/questions/29045140/env-bash-r-no-such-file-or-directory
```
git config --global core.autocrlf false
```