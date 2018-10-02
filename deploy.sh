#!/usr/bin/env bash
if [ "$TRAVIS_BRANCH" = "master" ] && [ "$TRAVIS_PULL_REQUEST" = "false" ]; then
    echo "step 0"
    pwd
    echo "step 1"
    gcloud --quiet components update kubectl
    echo "step 2"
    # Push to Google container registry
    docker build -t gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 .
    echo "step 2bis"
    gcloud auth configure-docker
    echo "step 3"
    #gcloud docker --verbosity=error -- push gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 > /dev/null
    #https://medium.com/google-cloud/using-googles-private-container-registry-with-docker-1b470cf3f50a
    docker push gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1
    #gcloud components install docker-credential-gcloud
    #echo "step 3b"
    #docker-credential-gcloud configure-docker
    #gcloud auth configure-docker

    echo "Step 4"
    # Deploy to the cluster
    # https://github.com/kubernetes/kubernetes/issues/28612
    #gcloud config set container/use_client_certificate True
    gcloud container clusters get-credentials $CLOUDSDK_CORE_PROJECT
    echo "step 5"
    #  kubectl apply -f config/k8s/mongo.yml
    kubectl apply -f config/gcp/$MICROSERVICE_NAME.yml
    echo "step 6"
    kubectl rolling-update web-controller --image=gcr.io/$CLOUDSDK_CORE_PROJECT/$MICROSERVICE_NAME:v1 --image-pull-policy Always
    echo "done !"
fi
