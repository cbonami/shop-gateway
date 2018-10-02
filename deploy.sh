#!/usr/bin/env bash
if [ "$TRAVIS_BRANCH" = "master" ] && [ "$TRAVIS_PULL_REQUEST" = "false" ]; then
    gcloud --quiet components update kubectl
    # Build & push to Google container registry
    docker build -t eu.gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 .
    gcloud auth configure-docker
    # next line is not needed imo
    docker login -u _json_key -p "$(cat gcloud.json)" https://gcr.io
    docker push eu.gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1
    # Deploy to the cluster
    # https://github.com/kubernetes/kubernetes/issues/28612
    #gcloud config set container/use_client_certificate True
    gcloud container clusters get-credentials shop
    echo "step 5"
    #  kubectl apply -f config/k8s/mongo.yml
    kubectl apply -f config/k8s/$MICROSERVICE_NAME.yml
    echo "step 6"
    kubectl rolling-update web-controller --image=eu.gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 --image-pull-policy Always
    echo "done !"
fi