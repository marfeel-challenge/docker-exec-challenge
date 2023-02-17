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

get_datos ()
{
  echo "==> Info: Getting url argocd from cluster eks"
  for i in dev tst prd ; do
    aws eks update-kubeconfig --name eks-cluster-${i} --region eu-west-1
    urlArgocd=$(kubectl get svc argocd-server -n argocd -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
    argoPass=$(kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d)
    echo "==> Info: Url argocd del entorno de ${i} is ${urlArgocd}"
    echo "==> Info: Password argocd del entorno de ${i} is ${argoPass}"
  done

}
main () {
  cloneRepos
  execTerraform
}
main "$@"
