FROM ubuntu:rolling@sha256:54bb6cbe5bfa4c5741fc8baa547dc95cf3fdbd5c55a5ed4784fed077e0bf9d87

LABEL maintainer="Atomist <docker@atomist.com>"

# Install Git
RUN apt-get update && \
    apt-get install -y git=1:2.27.0-1ubuntu1.1 && \
    apt-get clean -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Node.js and NPM
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && \
    apt-get install -y curl=7.68.0-1ubuntu4.3 && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs=14.16.1-deb-1nodesource1 && \
    apt-get remove -y curl && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ENV VARs needed for Node.js
ENV BLUEBIRD_WARNINGS 0
ENV NODE_ENV production
ENV NODE_NO_WARNINGS 1
ENV NPM_CONFIG_LOGLEVEL warn
ENV SUPPRESS_NO_CONFIG_WARNING true

# Install latest version of the Atomist CLI
RUN npm install -g @atomist/skill@0.9.1 \
    && rm -rf /root/.npm/
 
# Set working directory for container skills 
WORKDIR "/atm/home"

# Define the entrypoint
ENTRYPOINT ["atm-skill"]
CMD ["help"]

# Temporary fix CVE-2021-20305
RUN apt-get update && \
    apt-get install -y libhogweed6=3.6-2ubuntu0.1 libnettle8=3.6-2ubuntu0.1 && \
    apt-get clean -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*
