FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY /app /app
ENTRYPOINT ["dotnet", "dotnet-core.dll"]