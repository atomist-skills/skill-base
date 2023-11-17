FROM alpine:3.18@sha256:c0669ef34cdc14332c0f1ab0c2c01acb91d96014b172f1a76f3a39e63d1f0bda

LABEL maintainer="Atomist <docker@atomist.com>"

# Install common dependencies
RUN apk add --no-cache \
 curl=8.4.0-r0 \
 unzip=6.0-r14

# Install Node.js
RUN apk add --no-cache \
 nodejs=18.18.2-r0

# Install Git
RUN apk add --no-cache \
 git=2.40.1-r0
 
# ENV VARs needed for Node.js
ENV BLUEBIRD_WARNINGS=0 \
 NODE_ENV=production \
 NODE_NO_WARNINGS=1 \
 NPM_CONFIG_LOGLEVEL=warn \
 SUPPRESS_NO_CONFIG_WARNING=true

# Set working directory for container skills 
WORKDIR "/atm/home"

