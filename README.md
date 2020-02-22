



# Fast Start-up
1. Create VPC and Cluster in Amazon AWS: `ansible-playbook -i inventory main.yml -vvv`
2. Connect Github repo with Jenkins
3. Start Jenkins pipeline

# Project Overview
Project is consist of 3 parts: 
 - Jenkins setup and Jenkins pipeline defined in `Jenkinsfile`.
 - Development part 
 - Production deployment part

## Jenkins setup 
To setup Jenkins confogire this:
1. Install Hadolint: `wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64 && chmod +x /bin/hadolint`
2. Awscli install: pip install awscli
3. Install-aws-iam-authenticator
4. Install Docker : https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04
5. Install kubernetes : https://kubernetes.io/docs/tasks/tools/install-kubectl/
6. Install newest version of ansible
7. Install other useful packages: `pip install openshift boto boto3`

## Development part - Summary of project

Project overview:
* `model_data` folder : In this folder are data of prediction model.
* `output_txt_files` folder : You can find in this folder my outputs for docker deployment and for kubernetes deployment.
* `app.py` : This python file is lightweight flask app for predicting prices of houses in Boston. 
* `Dockerfile` : Containerized application app.py written as Dockerfile.
* `make_prediction.sh` : This bash script is used for testing deployed application. You can start it with : `bash make_prediction.sh`
* `make_prediction_production.sh` : This bash script is used for testing deployed application in production. You can start it with : `bash make_prediction_production.sh`
* `Makefile` : Makefile of the project.
* `README.md` : Quick guide how to start with this project.
* `requirements.txt` : This file includes dependencies needed for python. This dependencies needs to be installed before starting application.
* `run_docker.sh` : Bash script for building and running Docker container.
* `upload_docker.sh` : Bash script for uploading Docker container to DockerHub. You need credentials for danielmisik Docker account.
* `run_kubernetes.sh` : Bash script for building and running Kubernetes cluster with Docker.



### Setup the Environment

* Project was developing in Ubuntu 18.04. All commands are changed for using in this environment.
* Create a virtualenv and activate it : `python3 -m venv ~/.devops` `source ~/.devops/bin/activate`
* Run `make install` to install the necessary dependencies

### Running `app.py`

1. Standalone:  `python3 app.py`
2. Run in Docker:  `bash ./run_docker.sh`
3. Run in Kubernetes:  `bash ./run_kubernetes.sh`


### Docker deployment

* Start run_docker.sh file like this `bash ./run_docker.sh` for building and running Docker file.
* Start make_prediction.sh file like this `bash ./make_prediction.sh` for testing deployed app.
* Start make_prediction_production.sh file like this `bash ./make_prediction_production.sh` for testing deployed app in production.

### Kubernetes on localhost

* Setup and Configure Docker locally
* Setup and Configure Kubernetes locally
* Create Flask app in Container
* Run via kubectl

#### Kubernetes deployment and testing for localhost

* Start run_docker.sh file like this `bash ./run_docker.sh` for building Docker file.
* Start upload_docker.sh file like this `bash ./upload_docker.sh` for uploading Docker image to Dockerhub.
* Start run_kubernetes.sh file like this `bash ./run_kubernetes.sh` for starting kubernetes cluster.
* Start make_prediction.sh file like this `bash ./make_prediction.sh` for testing deployed app.

#### Quick tips for Kubernetes delete for localhost

Deployed application can be delete with this command: `kubectl delete deployment ml-service-kubectl`

## Production deployment part - AWS EKS Kubernetes Cluster 

This example demonstrates the setup of a highly-available AWS EKS Kubernetes cluster using Ansible to manage multiple CloudFormation templates.

### Cluster overview
 In this project I used partially changed source code from [this repo]( https://github.com/geerlingguy/ansible-for-kubernetes.git ) from book Ansible for Kubernetes by Jeff Geerling.
Buy [Ansible for Kubernetes](https://www.ansibleforkubernetes.com/) for your e-reader or in paperback format.

From this repo are all EKS Kubernetes Cluster files:
 - main.py
 - deploy.py
 - cloudformation/*
 - housepred/*
 - vars/*
 - delete.py
 - inventory
 - ansible-lint

### Usage

Prerequisites:

  - You must have an AWS account to run this example.
  - You must use an IAM account with privileges to create VPCs, Internet Gateways, EKS Clusters, Security Groups, etc.
  - This IAM account will inherit the `system:master` permissions in the cluster, and only that account will be able to make the initial changes to the cluster via `kubectl` or Ansible.

#### Build the Cluster via CloudFormation Templates with Ansible

Make sure you have the `boto` Python library installed (e.g. via Pip with `pip3 install boto`), and then run the playbook to build the EKS cluster and nodegroup:

    $ ansible-playbook -i inventory main.yml

> Note: EKS Cluster creation is a slow operation, and could take 10-20 minutes.

After the cluster and nodegroup are created, you should see one EKS cluster and three EC2 instances running, and you can start to manage the cluster with Ansible.

#### Set up authentication to the cluster via `kubeconfig`

  1. Install the `aws-iam-authenticator` following [these directions](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html).
  2. Create a `kubeconfig` file for EKS following [these directions](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html):

     ```
     $ aws eks --region eu-central-1 update-kubeconfig --name eks-housepred-services --kubeconfig ~/.kube/eks-housepred-services
     ```

     This creates a `kubeconfig` file located in `~/kube/eks-housepred-services`.
  3. Tell `kubectl` where to find the `kubeconfig`:

     ```
     $ export KUBECONFIG=~/.kube/eks-housepred-services
     ```
  4. Test that `kubectl` can see the cluster:

     ```
     $ kubectl get svc
     NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
     kubernetes   ClusterIP   10.100.0.1   <none>        443/TCP   19m
     ```

#### Deploy an application to EKS with Ansible

There is a `deploy.yml` playbook which deploys a House Prediction Service into the Kubernetes cluster.

Run the playbook to deploy the website:

    $ ansible-playbook -i inventory deploy.yml

##### Manage DNS for House Prediction Service with Route53 and Ansible

If you set the following variables inside `vars/main.yml`, the Ansible playbook will also create a DNS A record pointing to the House Prediction Service Load Balancer for you:

    housepred_route53_zone: example.com
    housepred_route53_domain: housepred.example.com

Using this feature presumes you already have the hosted zone (e.g. `example.com`) configured in Route53.

> Note: If you don't have a zone configured in Route 53, you can leave these settings blank, and access the load balancer URL via DNS directly. You can find the load balancer's direct URL in the AWS Management Console, in the ELB's details in EC2 > Load Balancers.



#### Delete the cluster and associated resources

After you're finished testing the cluster, run the `delete.yml` playbook:

    $ ansible-playbook -i inventory delete.yml

> Note: It's important to delete test clusters you're not actively using; each cluster is billed at the [EKS cluster hourly rate](https://aws.amazon.com/eks/pricing/) and can lead to unexpected charges at the end of the month!





https://github.com/MagalixCorp/k8scicd/blob/master/Jenkinsfile