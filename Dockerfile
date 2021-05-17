FROM ubuntu:rolling@sha256:be154cc2b1211a9f98f4d708f4266650c9129784d0485d4507d9b0fa05d928b6

LABEL maintainer="Atomist <docker@atomist.com>"

# Install Git
RUN apt-get update && apt-get install -y \ 
 git \
 && apt-get clean -y \
 && rm -rf /var/cache/apt /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Node.js and NPM
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && apt-get install -y \
 curl \
 build-essential \
 && curl -sL https://deb.nodesource.com/setup_14.x | bash - \ 
 && apt-get install -y nodejs=14.17.0-deb-1nodesource1 \ 
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
RUN npm install -g @atomist/skill@0.9.1 \
 && rm -rf /root/.npm/
 
# Set working directory for container skills 
WORKDIR "/atm/home"

# Define the entrypoint
ENTRYPOINT ["atm-skill"]
CMD ["help"]
