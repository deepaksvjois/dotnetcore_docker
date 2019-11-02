#Dot Net Project and Configuration
```
dotnet new webapi
dotnet build
dotnet run
dotnet publish -c release -o /app
```

#Docker and Configuration
```
docker build -t dotnetdemo
docker run -p 8181:80 dotnetdemo
```

#create azure resource group
```
az group create --name dotnetdemo --location eastus
```

#create azure container registery in azure
```
az acr create -g dotnetdemo --name dotnetContainerDemo --sku Basic --admin-enabled true
```

#Getting Creadential
```
az acr credential show -n dotnetContainerDemo
```

# Docker Tag
```
docker tag dotnetdemo dotnetcontainerdemo.azurecr.io/dotnetdemo:v1
```

# Docker Login / Connect to registery
```
docker login https://dotnetcontainerdemo.azurecr.io -u dotnetcontainerdemo -p zpnX7miVYJTZjPjVIHriT3h//wcVbDd1
```

# Docker Push / Image
```
docker push dotnetcontainerdemo.azurecr.io/dotnetdemo:v1
```
# Create App service Plan
```
az appservice plan create -n dotnetdemoplan -g dotnetdemo --sku S1 --is-linux
```

# Create Web App
```
az webapp create -g dotnetdemo -p dotnetdemoplan -n dotnetdockerdemo --runtime "DOTNETCORE|2.2"
az webapp create --resource-group myResourceGroup --plan myAppServicePlan --name <app-name> --deployment-container-image-name <azure-container-registry-name>.azurecr.io/mydockerimage:v1.0.0
```

#Configure Container to Web app
```
az webapp config container set -n dotnetdockerdemo -g dotnetdemo --docker-custom-image-name dotnetcontainerdemo.azurecr.io/dotnetdemo:v1 --docker-registry-server-url https://dotnetcontainerdemo.azurecr.io --docker-registry-server-user dotnetContainerDemo --docker-registry-server-password zpnX7miVYJTZjPjVIHriT3h//wcVbDd1
```