#!/bin/bash
# Script used by GitHub actions to set up dependency helm repositories for Chart Releaser tool
# This is required since Chart Releaser does not pull down dependent resources

set -o pipefail

main() {
  check_helm_installed

  declare -A arr

  arr+=(
         ["ucsd"]="https://lib-helm-repo.ucsd.edu"
         ["bitnami"]="https://charts.bitnami.com/bitnami"
       )

  for key in ${!arr[@]};
  do
    helm repo add ${key} ${arr[${key}]}
  done
}

check_helm_installed() {
  helm version --short | grep "v3" > /dev/null 2>&1
  if [[ $? > 0 ]]; then
    echo "Helm is not installed or not a valid version"
    exit 1
  fi
}

main
