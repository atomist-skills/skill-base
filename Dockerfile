FROM alpine:3.15
LABEL maintainer="Atomist <docker@atomist.com>"

ARG GIT_VERSION="2.34.1-r0"
ARG NODE_VERSION="16.13.0-r0"
ARG NPM_VERSION="8.1.3-r0"

# Install Git
RUN apk add --no-cache \
 git=$GIT_VERSION 

# Install Node.js and NPM
RUN apk add --no-cache \
 nodejs=$NODE_VERSION \
 npm=$NPM_VERSION

# ENV VARs needed for Node.js
ENV BLUEBIRD_WARNINGS=0 \
 NODE_ENV=production \
 NODE_NO_WARNINGS=1 \
 NPM_CONFIG_LOGLEVEL=warn \
 SUPPRESS_NO_CONFIG_WARNING=true

# Set working directory for container skills 
WORKDIR "/atm/home"

# Define the entrypoint
ENTRYPOINT ["atm-skill"]
CMD ["help"]
