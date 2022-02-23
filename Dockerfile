FROM alpine:3.15@sha256:21a3deaa0d32a8057914f36584b5288d2e5ecc984380bc0118285c70fa8c9300
LABEL maintainer="Atomist <docker@atomist.com>"

# Install common dependencies 
RUN apk add --no-cache \
 curl=7.80.0-r0 \
 unzip=6.0-r9

# Install Git
RUN apk add --no-cache \
 git=2.34.1-r0 
 
# Install Node.js
RUN apk add --no-cache \
 nodejs=16.14.0-r0

# ENV VARs needed for Node.js
ENV BLUEBIRD_WARNINGS=0 \
 NODE_ENV=production \
 NODE_NO_WARNINGS=1 \
 NPM_CONFIG_LOGLEVEL=warn \
 SUPPRESS_NO_CONFIG_WARNING=true

# Set working directory for container skills 
WORKDIR "/atm/home"
