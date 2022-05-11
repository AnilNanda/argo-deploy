#!/bin/sh -l

sleep 20

image=$1
app_name=$3
service_name=$4
env=$5
git_user="k8s-deployment"
git_password=$2
k8srepo="k8s-deployment-files/k8s-apps"


account_id=`echo $image | cut -d '/' -f 1 | cut -d '.' -f 1`
region=`echo $image | cut -d '/' -f 1 | cut -d '.' -f 4`
repository=`echo $image | cut -d '/' -f 2 | cut -d ':' -f 1`
image_tag=`echo $image | cut -d '/' -f 2 | cut -d ':' -f 2`


mkdir -p /tmp/eks-deployment
git clone https://$git_user:$git_password@github.com/$k8srepo /tmp/eks-deployment
cd /tmp/eks-deployment
yq -i eval ".${service_name}.image.tag = \"$image_tag\"" ${app_name}/${env}-values.yaml
git config user.email "$git_user"
git config user.name "$git_user"
git add .
git commit -m "Image tag in ${app_name}/${env}-values.yaml for ${service_name} with $image_tag"
git push
echo "Updated image tag in ${app_name}/${env}-values.yaml for ${service_name}"


status="Updated image tag in ${app_name}/${env}-values.yaml for ${service_name}"
echo "::set-output name=status::$status"
