FROM mcr.microsoft.com/dotnet/sdk:5.0.102-ca-patch-buster-slim

# Dockerfile meta-information
LABEL maintainer="byndyusoft" \
    app_name="dotnet-sonar"

ENV SONAR_SCANNER_MSBUILD_VERSION=5.0.4.24009 \
    DOTNETCORE_SDK=5.0.102 \
    DOTNETCORE_RUNTIME=5.0.2 \
    NETAPP_VERSION=net5.0 \
    DOCKER_VERSION=5:19.03.13~3-0~debian-buster \
    CONTAINERD_VERSION=1.3.7-1 \
    OPENJDK_VERSION=11

# Linux update
RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

# Install Java
RUN apt-get install -y openjdk-$OPENJDK_VERSION-jre


# Install Sonar Scanner
RUN dotnet tool install --global dotnet-sonarscanner

# Cleanup
RUN apt-get -q autoremove \
    && apt-get -q clean -y \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*.bin
