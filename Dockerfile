FROM ubuntu@sha256:54bb6cbe5bfa4c5741fc8baa547dc95cf3fdbd5c55a5ed4784fed077e0bf9d87

LABEL maintainer="Atomist <docker@atomist.com>"

# Install some common packages
RUN apt-get update && apt-get install -y \
    curl=7.68.0-1ubuntu4.3 \
    wget=1.20.3-1ubuntu1 \
    gnupg=2.2.20-1ubuntu1.1 \
    build-essential=12.8ubuntu3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Node and NPM
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y \
    nodejs=14.16.1-deb-1nodesource1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# ENV VARs needed for Node.js
ENV BLUEBIRD_WARNINGS 0
ENV NODE_ENV production
ENV NODE_NO_WARNINGS 1
ENV NPM_CONFIG_LOGLEVEL warn
ENV SUPPRESS_NO_CONFIG_WARNING true

# Install latest version of the Atomist CLI
RUN npm install -g @atomist/skill@0.9.1 \
    && rm -rf /root/.npm/
    
WORKDIR "/atm/home"

# Define the entrypoint
ENTRYPOINT ["atm-skill"]
CMD ["help"]
