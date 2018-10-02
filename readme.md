# Shop Gateway

## Travis

```
travis login
travis encrypt "DOCKER_USER=cbonami" --add env.global
travis encrypt "DOCKER_PASS=xxxxxxxxx" --add env.global
```

Make service account on GCP 
* IAM > Service Accounts
* Project > Edit

```
cat project-shop-gateway.json | base64
```

> see pastebin.md for key

* GCLOUD_EMAIL: travis@refined-algebra-215620.iam.gserviceaccount.com
* GCLOUD_KEY: base64-encoded version of project_name-xxxxx.json
* CLOUDSDK_CORE_DISABLE_PROMPTS: 1
* CLOUDSDK_CORE_PROJECT: your project name on gcloud; eg: shop
* CLOUDSDK_COMPUTE_ZONE: europe-west1-b	
* GKE_USERNAME: cbonami@gmail.com
* GKE_PASSWORD: 
* GKE_SERVER: the cluster IP: 35.205.224.241

## Links

* [Spring Cloud Gateway - Baeldung](https://www.baeldung.com/spring-cloud-gateway)
* [Spring Cloud Gateway - Routing Example](https://stackoverflow.com/questions/48865174/spring-cloud-gateway-proxy-forward-the-entire-sub-part-of-url)
* [Deploying from Travis to GCE](http://thylong.com/ci/2016/deploying-from-travis-to-gce/)

https://stackoverflow.com/questions/29045140/env-bash-r-no-such-file-or-directory
git config --global core.autocrlf false