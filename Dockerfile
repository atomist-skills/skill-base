FROM ubuntu:rolling

# ENV VARs needed for Node.js
ENV BLUEBIRD_WARNINGS 0
ENV NODE_ENV production
ENV NODE_NO_WARNINGS 1
ENV NPM_CONFIG_LOGLEVEL warn
ENV SUPPRESS_NO_CONFIG_WARNING true

# Install some common packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    gnupg \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install node and npm
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get -y install nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install latest versio of the Atomist cli
RUN npm install -g @atomist/skill \
    && rm -rf /root/.npm/
    

WORKDIR "/atm/home"

ENTRYPOINT ["atm-skill"]
