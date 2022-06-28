FROM alpine:3.16@sha256:686d8c9dfa6f3ccfc8230bc3178d23f84eeaf7e457f36f271ab1acc53015037c

LABEL maintainer="Atomist <docker@atomist.com>"

# Install common dependencies 
RUN apk add --no-cache \
 curl=7.83.1-r1 \
 unzip=6.0-r9

# Install Node.js
RUN apk add --no-cache \
 nodejs=16.15.0-r1

# Install Git
RUN apk add --no-cache \
 git=2.36.1-r0 
 
# ENV VARs needed for Node.js
ENV BLUEBIRD_WARNINGS=0 \
 NODE_ENV=production \
 NODE_NO_WARNINGS=1 \
 NPM_CONFIG_LOGLEVEL=warn \
 SUPPRESS_NO_CONFIG_WARNING=true

# Set working directory for container skills 
WORKDIR "/atm/home"

