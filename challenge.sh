#!/bin/bash

gitOrg="marfeel-challenge"
respos="terraform-install-eks terraform-install-apps"

cloneRepos () {
  for repo in $respos; do
    git clone https://github.com/$gitOrg/$repo.git
  done
}
execTerraform () {
  for repo in $respos; do
    cd $repo
    terraform init
    terraform plan
    if terraform apply -auto-approve ; then
      echo "Terraform apply ${repo} success"
    else
      echo "Terraform apply ${repo} failed"
      terraform destroy -auto-approve
      exit 1
    fi
    cd ..
  done
}

main () {
  cloneRepos
  execTerraform
}
main "$@"
