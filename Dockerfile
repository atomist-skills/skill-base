FROM alpine:3.18@sha256:eece025e432126ce23f223450a0326fbebde39cdf496a85d8c016293fc851978

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

