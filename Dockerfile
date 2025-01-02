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
ARG MILL_VERSION=0.12.5

# Install mill
RUN \
  curl -L -o /usr/local/bin/mill https://github.com/lihaoyi/mill/releases/download/$MILL_VERSION/$MILL_VERSION && \
  chmod +x /usr/local/bin/mill

# Copy build files
COPY build.sc ./

# Prepare offline dependencies for all Scala versions
RUN mill __.prepareOffline && rm build.sc

FROM base AS test

RUN mill --version
