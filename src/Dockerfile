ARG VERSION=latest
ARG OS=debian
ARG CLI_NAME=toolbox

FROM cloudposse/geodesic:$VERSION-$OS

# Set up temurin eclipse adoptium key
RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null
# Configure adoptium repository
RUN echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list

# Install various packages
RUN apt-get update && \
    apt-get install -y --allow-downgrades --no-install-recommends \
    gnupg=2.2.27-2+deb11u2 \
    wget apt-transport-https gpg \
    temurin-20-jdk \
    docker.io \
    kitty-terminfo=0.19.3-1 && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists/* 

# Install node
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - && \
    apt-get install -y nodejs

# Enable corepack, enabling yarn (https://yarnpkg.com/getting-started/install)
RUN corepack enable

# Install JDK
#RUN apt-get update && \
#    apt-get install -y --allow-downgrades --no-install-recommends \
#    temurin-21-jdk\

# Install maven
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz; \
    tar xzvf apache-maven-3.9.6-bin.tar.gz; \
    mv apache-maven-3.9.6 /opt/;

ENV PATH="/opt/apache-maven-3.9.6/bin:$PATH"

# Install taskfile
RUN cd /; sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d

# Shell banner
ENV BANNER="sfrunner"
ENV MOTD_URL=""

ENV SHELL=/bin/bash

ENV AWS_VAULT_ENABLED=false
ENV AWS_VAULT_SERVER_ENABLED=false
ENV AWS_VAULT_BACKEND=file

# AWS CLI Configurations
ENV AWS_SDK_LOAD_CONFIG=1
ENV AWS_SESSION_TOKEN_TTL=3h
ENV AWS_ASSUME_ROLE_TTL=3h
ENV AWS_FEDERATION_TOKEN_TTL=3h
ENV AWS_DEFAULT_REGION=us-east-1
ENV AWS_DEFAULT_SHORT_REGION=ue1
ENV AWS_REGION_ABBREVIATION_TYPE=fixed

ENV DOCKER_IMAGE="sfrunner"
ENV DOCKER_TAG="latest"

ENV JAVA_HOME=/usr/lib/jvm/temurin-20-jdk-arm64

WORKDIR /