FROM ubuntu:rolling@sha256:a30456233740024b9d297f5bcaa7439446a97bc59b25cadcdae829c334827945

LABEL maintainer="Atomist <docker@atomist.com>"

# Install Git
RUN apt-get update && apt-get install -y \
    git=1:2.30.2-1ubuntu1 \
 && apt-get clean -y \
 && rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Node.js and NPM
# atomist:apt-source=deb https://deb.nodesource.com/node_14.x hirsute main
RUN apt-get update && apt-get install -y \
    build-essential=12.8ubuntu3 \
    curl=7.74.0-1ubuntu2 \
 && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
 && apt-get update && apt-get install -y \
    nodejs=14.17.2-deb-1nodesource1 \
 && apt-get remove -y curl \
 && apt-get autoremove -y \
 && apt-get clean -y \
 && rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ENV VARs needed for Node.js
ENV BLUEBIRD_WARNINGS=0 \
 NODE_ENV=production \
 NODE_NO_WARNINGS=1 \
 NPM_CONFIG_LOGLEVEL=warn \
 SUPPRESS_NO_CONFIG_WARNING=true

# Install latest version of the Atomist CLI
RUN npm install -g @atomist/skill@0.11.0 \
 && rm -rf /root/.npm/
 
# Set working directory for container skills 
WORKDIR "/atm/home"

# Define the entrypoint
ENTRYPOINT ["atm-skill"]
CMD ["help"]

# Fix CVE-2021-3520
RUN apt-get update && apt-get install -y \
    liblz4-1=1.9.3-1ubuntu0.1 \
 && apt-get clean -y \
 && rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
