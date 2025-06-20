#
# Scala and Mill Dockerfile
#
# https://github.com/nightscape/scala-mill
#

# Pull base image
ARG BASE_IMAGE=ghcr.io/graalvm/graalvm-ce:latest
FROM --platform=$TARGETPLATFORM ${BASE_IMAGE} AS base

# Define working directory
WORKDIR /root

# Env variables
ARG MILL_VERSION=0.12.14

# Install mill
RUN \
  curl -L -o /usr/local/bin/mill https://repo1.maven.org/maven2/com/lihaoyi/mill-dist/$MILL_VERSION/mill-dist-$MILL_VERSION-mill.sh && \
  chmod +x /usr/local/bin/mill

# Copy build files
COPY build.sc ./

# Prepare offline dependencies for all Scala versions
RUN mill __.prepareOffline && rm build.sc

FROM base AS test

RUN mill --version
