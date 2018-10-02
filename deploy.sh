#!/usr/bin/env bash
if [ "$TRAVIS_BRANCH" = "master" ] && [ "$TRAVIS_PULL_REQUEST" = "false" ]; then
    echo "step 0"
    pwd
    echo "step 1"
    gcloud --quiet components update kubectl
    echo "step 2"
    # Push to Google container registry
    docker build -t gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 .
    echo "step 3"
    #gcloud components install docker-credential-gcloud
    #echo "step 3b"
    #docker-credential-gcloud configure-docker
    #gcloud auth configure-docker
    echo "step 4"
    gcloud config set container/use_client_certificate True
    gcloud container clusters get-credentials $CLOUDSDK_CORE_PROJECT
    echo "step 5"
    docker push gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1
    echo "step 6"
    # Deploy to the cluster
    #  kubectl apply -f config/k8s/mongo.yml
    kubectl apply -f config/gcp/$MICROSERVICE_NAME.yml
    echo "step 7"
    kubectl rolling-update web-controller --image=gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 --image-pull-policy Always
    echo "done !"
fi
