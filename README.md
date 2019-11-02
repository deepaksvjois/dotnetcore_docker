## Prerequisites

- Docker Desktop
- Visual Studio Code
- VS Code Extension: Azure Tools and Docker
- Azure Container Registry, an Azure subscription

## Step 1: Creating .Net Core App and Publish

```
dotnet new webapi
dotnet build
dotnet run
dotnet publish -c release -o /app
```

## Step 2: Creating Docker file

The Dockerfile file is used by the docker build command to create a container image

```
FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY /app /app
ENTRYPOINT ["dotnet", "<project-name>.dll"]
```

## Step 3: Docker Ignore

Docker ignore will improvise docker build performance based on eliminating content defined on .dockerignore

```
bin/
obj/
```

## Step 4: Build Docker Container

The docker build command builds Docker images from a Dockerfile and a “context”.

```
docker build -t <tag_name>
```

## Step 5: Running the Docker Image

The docker run command first creates a writeable container layer over the specified image.

```
docker run -p <local_system_port>:<docker_port> <tag_name>
docker run -p 8080:80 <tag_name>
Test Application: (http://localhost:8080/api/values)
```

## Step 6: Create azure resource group

Using Azure Cli create the Resource Group, Container registry and Webapp much more.

```
az group create --name <group_name> --location <location>
az group create --name demogroup --location eastus
```

## Step 7:  Create azure container registry

Azure Container Registry allows you to store images for all types of container deployments including DC/OS, Docker Swarm, Kubernetes and Azure services such as App Service, Batch, Service Fabric and others

```
az acr create --name <container_name> -g <group_name>
az acr create -g demogroup --name demoContainerRegistry --sku Basic --admin-enabled true
```

### Step 7.1: Getting the container credentials

```
az acr credential show -n <container_registery_name>
az acr credential show -n demoContainerRegistry
```

## Step 8: Tag Docker Image with registry reference

```
docker tag <registry_uri>/<name:version>
docker tag demoContainerRegistry.azurecr.io/dotnetdemo:v1
```

## Step 9: Login to Container Registry

The docker push command Push an image or a repository to a registry

```
docker login https://<registry_uri> -u <username> -p <parrword>
-u <registry-username>
-p <registry-password>
```

## Step 10: Publish your Docker Image to Azure Container Registry

```
docker push <docker_tag_name> (<registry_uri>/<name:version>)
```

## Step 11: Deploy Container as Webapp

### Step 11.1: Creating Service Plan

```
az appservice plan create -n <plan_name> -g <group_name>
az appservice plan create -n demoplan -g demogroup --sku S1 --is-linux
```

### Step 11.2: Creating WebApp

```
az webapp create -g <group_name> -p <plan_name> -n <app-name> --deployment-container-image-name <azure-container-registry-name>
```

### Step 11.3: Configure WebApp with Container Registry

```az webapp config container set
-n <app-name>
-g <group>
--docker-custom-image-name <tag_name>
--docker-registry-server-url <container-registry-url>
--docker-registry-server-user <username>
--docker-registry-server-password <password>
```

### Step 11.4 Test you Application

<app-name>.azurewebsites.net
