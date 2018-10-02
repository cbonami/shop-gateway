#!/bin/sh

# Install kubernetes and set config
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
#curl -o config https://$GITHUB_ACCESS_TOKEN@raw.githubusercontent.com/GithubOrganization/MySecretInfrastructureRepo/master/.kube/config

gcloud version || true
if [ ! -d "$HOME/google-cloud-sdk/bin" ]; then rm -rf $HOME/google-cloud-sdk; export CLOUDSDK_CORE_DISABLE_PROMPTS=1; curl https://sdk.cloud.google.com | bash; fi
# Add gcloud to $PATH
source /home/travis/google-cloud-sdk/path.bash.inc
gcloud version


unzip -P $ZIP_PASSWORD config.zip
unzip -P $ZIP_PASSWORD service-account-secret.zip
mkdir ${HOME}/.kube
cp config ${HOME}/.kube/config

# Fill out missing params in kubectl config file
#kubectl config set clusters.kubernetes-kube-group-e1ea0b.certificate-authority-data "$KUBE_CLUSTER_CERTIFICATE"
#kubectl config set users.kubernetes-kube-group-e1ea0b-admin.client-certificate-data "$KUBE_CLIENT_CERTIFICATE"
#kubectl config set users.kubernetes-kube-group-e1ea0b-admin.client-key-data "$KUBE_CLIENT_KEY"