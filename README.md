[![danomisik](https://circleci.com/gh/danomisik/ml-microservice-kubernetes.svg?style=svg)](https://circleci.com/gh/danomisik/ml-microservice-kubernetes)

## Project Overview

In this project, you will apply the skills you have acquired in this course to operationalize a Machine Learning Microservice API. 

You are given a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). This project tests your ability to operationalize a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

### Project Tasks

Your project goal is to operationalize this working, machine learning microservice using [kubernetes](https://kubernetes.io/), which is an open-source system for automating the management of containerized applications. In this project you will:
* Test your project code using linting
DONE: `make lint ` or push code to github and circle ci will start whole pipelne with linting
* Complete a Dockerfile to containerize this application
DONE: You can check ./Dockerfile for implementation of Dockerfile
* Deploy your containerized application using Docker and make a prediction
DONE: You can check implemented result in files: ./run_docker.sh , ./upload_docker.sh and ./make_predition.sh
* Improve the log statements in the source code for this application
DONE: I added log statement for logging predition output. You can see it in app.py
* Configure Kubernetes and create a Kubernetes cluster
DONE: I configured Kubernetes and 
* Deploy a container using Kubernetes and make a prediction
DONE: I deployed Kubernetes cluster, you can see used commands inside ./run_kubernetes.sh
* Upload a complete Github repo with CircleCI to indicate that your code has been tested
DONE: I fully integrated CircleCI with my github repo. You can see markdown PASSED in top of README file.

You can find a detailed [project rubric, here](https://review.udacity.com/#!/rubrics/2576/view).

**The final implementation of the project will showcase your abilities to operationalize production microservices.**

---
## Summary of project

Project overview:
* `.circleci/config.yml` : Implementation of circleci configuration file. This file is important for CircleCI integration with github repo.
* `model_data` folder : In this folder are data of prediction model.
* `output_txt_files` folder : You can find in this folder my outputs for docker deployment and for kubernetes deployment.
* `app.py` : This python file is lightweight flask app for predicting prices of houses in Boston. 
* `Dockerfile` : Containerized application app.py written as Dockerfile.
* `make_prediction.sh` : This bash script is used for testing deployed application. you can start it with : `bash make_prediction.sh`
* `Makefile` : Makefile of the project.
* `README.md` : Quick guide how to start with this project.
* `requirements.txt` : This file includes dependencies needed for python. This dependencies needs to be installed before starting application.
* `run_docker.sh` : Bash script for building and running Docker container.
* `upload_docker.sh` : Bash script for uploading Docker container to DockerHub. You need credentials for danielmisik Docker account.
* `run_kubernetes.sh` : Bash script for building and running Kubernetes cluster with Docker.



## Setup the Environment

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

### Kubernetes Steps

* Setup and Configure Docker locally
* Setup and Configure Kubernetes locally
* Create Flask app in Container
* Run via kubectl

#### Kubernetes deployment and testing

* Start run_docker.sh file like this `bash ./run_docker.sh` for building Docker file.
* Start upload_docker.sh file like this `bash ./upload_docker.sh` for uploading Docker image to Dockerhub.
* Start run_kubernetes.sh file like this `bash ./run_kubernetes.sh` for starting kubernetes cluster.
* Start make_prediction.sh file like this `bash ./make_prediction.sh` for testing deployed app.

#### Quick tips for Kubernetes delete

Deployed application can be delete with this command: `kubectl delete deployment ml-service-kubectl`

## Problem solving
* If you will have problem start some bash script, it is probably because  Mac end-of-line in this files(original template of project was created in Mac). Just use this command and everything should be fine: `tr -d '\15\32' < macfile.txt > unixfile.txt`
* I had problem to build app.py properly, so I downgrade sklearn to 0.20.2 version. You can see it in requirements.txt as it is here: `scikit-learn==0.20.2`




