# Xebia Devops_interview_labs

```sh

Docker

# Base image based on https://github.com/coder/code-server/tree/main/ci/release-image
# Currently runs kubectl, and kind. The idea is to build whatever tool you want on top of it. It's not straight forward as where using a docker container to host and run docker itself. Filesystems are different, and networking works differently as well. So just be creative but mindful of the pitfalls. 
# .vscode directory is if you want to add custom vscode settings. 

Script

# Purpose of the create_lab.sh is to generate the J2 template yaml, create AKS cluster, and deploy the Lab based on the generated template. This can also be done in Python. All J2 inputs in the template is based {{ username }}. The value of {{ username }} is used to drive the entire architecture of the lab.

Kubernetes

# Secret - secret to your Image Repo Registry. This will be used for the 'imagepullsecret' in the deployment.yml
# PVC mount is optional. If you want to persist the work (files) that the end user works on, then use PVC to store in i.e. Azure Blob storage. If not, git is enabled, so end user can pull from a designated repo.
# ConfigMap overides code-server's default password. This allows us to control the generation of the passwd.
# Service - use type: "ClusterIP" if ingress is involved. If not, the application can be exposed via "type: LoadBalancer" which is currently being done. However, I've hashed out the configurations for ingress if required. Just change the annotation 'kubernetes.io/ingress.class: "kong"' for whatever ingress-controller you maybe using.
