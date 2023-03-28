FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

#Create App
RUN dotnet new console -o App -n DotNet.Docker
COPY ./project.cs App
RUN ls -l
# Build and publish a release
RUN dotnet publish DotNet.Docker.csproj -c Release -o out /app/publish
RUN ls -l

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]
