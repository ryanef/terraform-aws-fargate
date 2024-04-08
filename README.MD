# AWS Fargate Terraform Module
[Install Demo App](#test-demo-locally)

[Build Docker Images](#build-docker-images-and-push-to-elastic-container-registry)

[Create Fargate Infrastructure](##)

## Introduction

Use this Fargate module to experiment launching multiple services with NAT Gateway, VPC Endpoints or directly into public subnets. It also uses Service Connect(AWS CloudMap) for service discovery.

You don't have to include them manually but this uses [VPC](https://registry.terraform.io/modules/ryanef/vpc/aws/latest) and [Loadbalancer](https://registry.terraform.io/modules/ryanef/loadbalancer/aws/latest) modules for its base networking. They are imported in the `network.tf` in this module.

For tasks you want to keep in private subnets, you can use either VPC Endpoints or NAT Gateway.

To demo this I've put together 2 images that can be used in Fargate Task Definitions. If you want to follow along you'll need Docker, Terraform, node18+, Python 3.10 and an AWS account with administrator access.

## Setup Demo App
Frontend React Image - [Github Repo](https://github.com/ryanef/frontend-ecs-project)

Simple React app and NGINX in the same image. NGINX serves the static React files and configured to handle the client side routing. `nginx.conf` also includes a proxy_pass to `/api` for API calls to the Python backend and the AWS CloudMap DNS resolver `169.254.169.253` so services can communicate via names like http://frontend:3000 and http://backend:5000

FastAPI Backend Image - [Github Repo](https://github.com/ryanef/backend-ecs-project)

FastAPI with only a root / and /api route setup for responses to frontend API calls.

## Test Demo Locally

### Clone the frontend project files

```bash
git clone git@github.com:ryanef/frontend-ecs-project.git
cd frontend-ecs-project

# if you want to test locally before buiding images

npm install
npm run dev
```

When dev server starts in the CLI you should see a link like http://localhost:5142 to open in your browser. If the React app loads, build the image and push to ECR.

## Build Docker Images and Push to Elastic Container Registry

Make one ECR Repository for the frontend image and one for the backend image. Making a repository in AWS Console only takes a few seconds and they'll give you exact commands to copy and paste to push.

In the example below my ECR Repository is named "reactdevtest" for the frontend and "backenddevtest" for the backend image

Docker or Docker Desktop must be running and AWS CLI must be installed. Use push commands from ECR console or modify these with your REGION and AWS Account Number:

```bash
aws ecr get-login-password --region REGION | docker login --username AWS --password-stdin ACCOUNTNUMBER.dkr.ecr.REGION.amazonaws.com

docker build -t reactdevtest -f Dockerfile.prod .

docker tag reactdevtest:latest ACCOUNTNUMBER.dkr.ecr.REGION.amazonaws.com/reactdevtest:latest

docker push ACCOUNTNUMBER.dkr.ecr.REGION.amazonaws.com/reactdevtest:latest
```

### Clone backend project files

Put these in an entirely different directory than the frontend files or your image sizes will be huge.
```bash
git clone git@github.com:ryanef/backend-ecs-project.git

cd backend-ecs-project

# if you want to test locally 
# i recommend making a python virtual environment

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt

uvicorn app.main:app --port 5000
```

If it works, follow the same ECR Push instructions as the frontend. If you're using the same names as the guide then be sure to replace `reactdevtest` with `backenddevtest` in the docker build commands.