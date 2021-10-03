FROM ubuntu:rolling@sha256:44e4ce6defdd88435d6f724b4ed4bfa3dd7796c93012bbe1af16da4a7479a006

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
    curl=7.74.0-1ubuntu2.3 \
 && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
 && apt-get update && apt-get install -y \
    nodejs=14.18.0-deb-1nodesource1 \
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

# Fix some CVEs
RUN apt-get update && apt-get install -y \
    linux-libc-dev=5.11.0-37.41 \
    libgcrypt20=1.8.7-2ubuntu2.1 \
    libgd3=2.3.0-2ubuntu0.1 \
 && apt-get clean -y \
 && rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
