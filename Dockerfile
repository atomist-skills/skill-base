FROM alpine:edge@sha256:69361f5f421bb47db6f2f6baf84ab50b8f7c9b209f8376048dda955535224be8

LABEL maintainer="Atomist <docker@atomist.com>"

# Install common dependencies
RUN apk add --no-cache \
 curl=7.84.0-r2 \
 unzip=6.0-r10

# Install Node.js
RUN apk add --no-cache \
 nodejs=16.16.0-r1

# Install Git
RUN apk add --no-cache \
 git=2.37.1-r0
 
# ENV VARs needed for Node.js
ENV BLUEBIRD_WARNINGS=0 \
 NODE_ENV=production \
 NODE_NO_WARNINGS=1 \
 NPM_CONFIG_LOGLEVEL=warn \
 SUPPRESS_NO_CONFIG_WARNING=true

# Set working directory for container skills 
WORKDIR "/atm/home"

