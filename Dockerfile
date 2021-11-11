FROM ubuntu:rolling@sha256:f53c26896aaebc7727f3255c24e261b1b6f630a848a2e67c8cc5848d7c33f93f

LABEL maintainer="Atomist <docker@atomist.com>"

# Install Git
RUN apt-get update && apt-get install -y \
    git=1:2.32.0-1ubuntu1 \
 && apt-get clean -y \
 && rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Node.js and NPM
# atomist:apt-source=deb https://deb.nodesource.com/node_16.x hirsute main
RUN apt-get update && apt-get install -y \
    build-essential=12.9ubuntu2 \
    curl=7.74.0-1.3ubuntu2 \
 && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
 && apt-get update && apt-get install -y \
    nodejs=16.13.0-deb-1nodesource1 \
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
