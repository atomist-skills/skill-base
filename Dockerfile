FROM alpine:edge@sha256:5bd9939b4140caa8c716499e53438053b4e1aa872a170f4399ec71c00e23b835

LABEL maintainer="Atomist <docker@atomist.com>"

# Install common dependencies
RUN apk add --no-cache \
 curl=7.88.1-r1 \
 unzip=6.0-r13

# Install Node.js
RUN apk add --no-cache \
 nodejs=18.14.2-r0

# Install Git
RUN apk add --no-cache \
 git=2.39.2-r0
 
# ENV VARs needed for Node.js
ENV BLUEBIRD_WARNINGS=0 \
 NODE_ENV=production \
 NODE_NO_WARNINGS=1 \
 NPM_CONFIG_LOGLEVEL=warn \
 SUPPRESS_NO_CONFIG_WARNING=true

# Set working directory for container skills 
WORKDIR "/atm/home"

