# DevOps Pipeline Case Study Report

## Case Study Overview

This case study showcases a complete CI/CD DevOps pipeline for deploying a Node.js application using modern DevOps tools including Git, GitHub, Docker, Terraform, Ansible, Jenkins, and Shell scripting.

---

## Steps Completed

### Step 1: GitHub Repository Setup

* Created a public GitHub repository named `nodejs-devops-pipeline`, initialized with:

  * `README.md`
  * `.gitignore`

![alt text](<Screenshot 2025-07-23 171054.png>)

* Cloned the repository locally and initialized the case study folder structure and necessary files. Then, I
committed and pushed them to GitHub.

![alt text](<Screenshot 2025-07-23 172150.png>)

* Created a `develop` branch locally and pushed it to GitHub to separate development work from production
code.

![alt text](<Screenshot 2025-07-23 172249.png>)

* Enabled branch protection rules on the `main` branch, enforcing pull request-based merging from develop to
main. This ensures code quality and peer reviews before production deployment.

![alt text](<Screenshot 2025-07-23 172336.png>)

### Step 2: Node.js Application Creation

* Initialized a new `Node.js` project with default settings

* Installed the `Express.js` framework, which simplifies server creation

![alt text](<Screenshot 2025-07-23 172645.png>)

* Added code to `index.js`

* Tested locally using: `node src/index.js`

* Pushed All Code to GitHub

![alt text](<Screenshot 2025-07-23 173448-1.png>)

![alt text](<Screenshot 2025-07-23 173046.png>)

### Step 3: Dockerization & DockerHub

* Added a `Dockerfile` to the root directory

* Built the Docker image locally and run the Docker container to test locally:

![alt text](<Screenshot 2025-07-23 174912.png>)

* Verified the application by visiting: 

  * `http://localhost:3000`

![alt text](<Screenshot 2025-07-23 174921.png>)

* Logged in to Docker Hub:

* Tagged the image with Docker Hub repo name:

* Pushed the image to Docker Hub:

![alt text](<Screenshot 2025-07-23 175225.png>)

* Created the `build_and_push.sh` script to automate the build and push process:

* Changed permissions to make the script executable:

* Run the script to build and push automatically:

![alt text](<Screenshot 2025-07-23 175528.png>)

* Pushed All Code to GitHub

![alt text](<Screenshot 2025-07-23 175947.png>)

### Step 4: Terraform Infrastructure Provisioning

* Created `IAM User` in AWS

  * Assigned `AmazonEC2FullAccess` and `AmazonVPCFullAccess` policies.
  * Downloaded `Access Key` and `Secret Access Key`.

![alt text](<Screenshot 2025-07-19 225143.png>)

* Configured AWS CLI

![alt text](<Screenshot 2025-07-23 180708.png>)

* Wrote Terraform Configuration Files in infra/ directory

  * `variables.tf`
  * `main.tf`
  * `outputs.tf`

* Generated SSH Key Pair for EC2 Access

![alt text](<Screenshot 2025-07-23 183012.png>)

* Initialize and plan Terraform

![alt text](<Screenshot 2025-07-23 183247.png>)

* Applied Terraform Configuration

![alt text](<Screenshot 2025-07-23 183953.png>)

* Changed Private Key Permissions

  * `chmod 400 devops-server-key`

* ssh into the ec2 instance locally

![alt text](<Screenshot 2025-07-23 185108.png>)

* Updated `.gitignore` to Prevent Sensitive File Push

![alt text](<Screenshot 2025-07-23 191301.png>)

* Pushed All Code to GitHub

![alt text](<Screenshot 2025-07-23 191626.png>)

### Step 5: Ansible Deployment

* Added `deploy.yml` Ansible Playbook File and Added `host.ini` Inventory File

* Copied SSH Key into Home Directory for Ansible Access

* Changed Permission of the Private Key File

* Run Ansible Playbook

![alt text](<Screenshot 2025-07-23 205238.png>)

* Verified the application by visiting: 

  * `http://terraform-generate-ec2-instance-public-ip`

![alt text](<Screenshot 2025-07-23 205400.png>)

* Pushed All Code to GitHub

![alt text](<Screenshot 2025-07-23 210548.png>)

### Step 6: Jenkins CI/CD Pipeline

* Created and Pushed `Jenkinsfile`

  * Defined the pipeline using stages like clone, build, Docker push, Terraform provisioning, and Ansible deployment.
  * Deleted the previously committed `host.ini` file because it will now be dynamically generated in a Jenkins stage.

![alt text](<Screenshot 2025-07-23 220802.png>)

* Set Up Jenkins on Ubuntu VM

  * Jenkins server is hosted on a local virtual machine (Ubuntu).
  * Jenkins installed with Docker, Terraform, Ansible, Git plugins, AWSCLI

* Access Jenkins Dashboard

  * Opened Jenkins in browser: `http://localhost:8080`
  * Unlocked Jenkins using the admin password.
  * Installed suggested and required plugins including
  
    * Git plugin
    * Docker plugin
    * SSH agent
    * Pipeline
    * Ansible plugin
    * Terraform plugin

* Jenkins Credentials Setup

  * Added DockerHub credentials (ID: DockerHub) under Manage Jenkins -> Credentials for Docker login.
  * Configured AWS CLI using IAM user credentials

* Set Up SSH for Ansible & Terraform

  * Copied the SSH key pair to the Jenkins server

    * `sudo cp /mnt/c/Users/mites/Projects/nodejs-devops-pipeline/infra/devops-server-key /var/lib/jenkins/.ssh/`
    * `sudo cp /mnt/c/Users/mites/Projects/nodejs-devops-pipeline/infra/devops-server-key.pub /var/lib/jenkins/.ssh/`
    * `sudo chown jenkins:jenkins /var/lib/jenkins/.ssh/*`
    * `sudo chmod 600 /var/lib/jenkins/.ssh/devops-server-key`

* Created Jenkins Pipeline Job

* Triggered Pipeline and Observed Console Output

### Step 7: Cleanup Script

* Created `cleanup.sh` Script

* Committed & Pushed to GitHub

![alt text](<Screenshot 2025-07-24 233757.png>)

* Changed Script Permissions and run

![alt text](<Screenshot 2025-07-24 233929.png>)

* Created a New Jenkins Job: `cleanup-job`

  * Job Type: `Freestyle project`
  * Source Code Management (SCM)
  * Git Repository: Connected to the same GitHub repository using the HTTPS URL.
  * Branch: `main`
  * Build step: `Execute shell`

    * #!/bin/bash
    * chmod +x scripts/cleanup.sh
    * bash scripts/cleanup.sh

  * Tested End-to-End Pipeline

### Step 8: Documentation and Report Finalization

* Created `REPORT.md`

* Summarized all 7 steps of the DevOps pipeline implementation

* Pushed `REPORT.md` to GitHub

![alt text](<Screenshot 2025-07-25 010916.png>)

* Created a Pull Request

![alt text](<Screenshot 2025-07-25 011334.png>)

* Merged `develop` into `main`

![alt text](<Screenshot 2025-07-25 012354.png>)

---

## Screenshots & Logs

![alt text](image.png)

![alt text](image-1.png)

![alt text](image-2.png)

![alt text](image-3.png)

![alt text](image-4.png)

![alt text](image-5.png)

![alt text](image-6.png)

![alt text](image-7.png)

![alt text](image-8.png)

![alt text](image-9.png)

![alt text](image-10.png)

![alt text](image-11.png)

![alt text](<Screenshot 2025-07-24 235911.png>)

---

### DockerHub Repo

[https://hub.docker.com/repository/docker/miteshsaste/devops-nodejs-app](https://hub.docker.com/repository/docker/miteshsaste/devops-nodejs-app)

### GitHub Repository

[https://github.com/Mitesh-Saste/nodejs-devops-pipeline](https://github.com/Mitesh-Saste/nodejs-devops-pipeline)

---

**All 8 steps are complete.**
