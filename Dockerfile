FROM alpine:edge@sha256:c223f84e05c23c0571ce8decefef818864869187e1a3ea47719412e205c8c64e

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
 git=2.37.1-r1
 
# ENV VARs needed for Node.js
ENV BLUEBIRD_WARNINGS=0 \
 NODE_ENV=production \
 NODE_NO_WARNINGS=1 \
 NPM_CONFIG_LOGLEVEL=warn \
 SUPPRESS_NO_CONFIG_WARNING=true

# Set working directory for container skills 
WORKDIR "/atm/home"

