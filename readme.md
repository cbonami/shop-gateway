# Shop Gateway

## Travis

[Inspiration](http://thylong.com/ci/2016/deploying-from-travis-to-gce/)

Make service account on GCP 
* IAM > Service Accounts > Add
Roles:
* Project > Edit
* Storage Admin

```
gcloud projects add-iam-policy-binding shop -- member serviceAccount:travisci@refined-algebra-215620.iam.gserviceaccount.com -- role roles/storage.admin
cat project-shop-gateway.json | base64 > base64
```

> see pastebin.md for key

Travis project settings: env vars:

* GCLOUD_EMAIL: travisci@refined-algebra-215620.iam.gserviceaccount.com
* CLOUDSDK_CORE_PROJECT: your project id on gcloud; eg: refined-algebra-215620
* CLOUDSDK_COMPUTE_ZONE: europe-west1-b	
* GKE_SERVER: the cluster IP: 35.205.224.241
* MICROSERVICE_NAME: shop-gateway
* GKE_USERNAME: cbonami@gmail.com
* GKE_PASSWORD: 

## Links

* [Spring Cloud Gateway - Baeldung](https://www.baeldung.com/spring-cloud-gateway)
* [Spring Cloud Gateway - Routing Example](https://stackoverflow.com/questions/48865174/spring-cloud-gateway-proxy-forward-the-entire-sub-part-of-url)
* [Deploying from Travis to GCE](http://thylong.com/ci/2016/deploying-from-travis-to-gce/)

https://stackoverflow.com/questions/29045140/env-bash-r-no-such-file-or-directory
```
git config --global core.autocrlf false
```