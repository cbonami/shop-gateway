#!/usr/bin/env bash
if [ "$TRAVIS_BRANCH" = "master" ] && [ "$TRAVIS_PULL_REQUEST" = "false" ]; then
    echo "step 0"
    pwd
    echo "step 1"
    gcloud --quiet components update kubectl
    echo "step 2"
    # Push to Google container registry
    docker build -t eu.gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 .
    echo "step 2bis"
    gcloud auth configure-docker
    echo "step - login"
    #gcloud docker --verbosity=error -- push gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 > /dev/null
    #https://medium.com/google-cloud/using-googles-private-container-registry-with-docker-1b470cf3f50a
    docker login -u _json_key -p "$(cat gcloud.json)" https://gcr.io
    echo "step - push"
    docker push eu.gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1
    echo "Step 4"
    # Deploy to the cluster
    # https://github.com/kubernetes/kubernetes/issues/28612
    #gcloud config set container/use_client_certificate True
    gcloud container clusters get-credentials $CLOUDSDK_CORE_PROJECT
    echo "step 5"
    #  kubectl apply -f config/k8s/mongo.yml
    kubectl apply -f config/k8s/$MICROSERVICE_NAME.yml
    echo "step 6"
    kubectl rolling-update web-controller --image=eu.gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 --image-pull-policy Always
    echo "done !"
fi
