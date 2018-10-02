#!/usr/bin/env bash
if [ "$TRAVIS_BRANCH" = "master" ] && [ "$TRAVIS_PULL_REQUEST" = "false" ]; then
    echo "step 1"
    gcloud --quiet components update kubectl
    echo "step 2"
    # Push to Google container registry
    docker build -t eu.gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 .
    echo "step 3"
    gcloud components install docker-credential-gcr
    gcloud auth configure-docker
    echo "step 3b"
    docker push eu.gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1
    echo "step 4"
    # Deploy to the cluster
    gcloud container clusters get-credentials $CLOUDSDK_CORE_PROJECT
    echo "step 5"
    #  kubectl apply -f config/k8s/mongo.yml
    kubectl apply -f config/gcp/$MICROSERVICE_NAME.yml
    echo "step 6"
    kubectl rolling-update web-controller --image=gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 --image-pull-policy Always
    echo "done !"
fi
