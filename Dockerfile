# """
# Dockerfile for Python Application
# ---------------------------------
#
# Builds a container for a Python app using a slim Debian base image.
#
# Usage:
#     Build:
#         docker build --build-arg BUILD_VERSION=1.0.0 --build-arg ENV=production -t my-python-app .
#     Run:
#         docker run -e ENV=production -e BUILD_VERSION=1.0.0 my-python-app
#
# Arguments:
#     BUILD_VERSION: Build version of the app (set at build time).
#     ENV: Environment (development, production, etc.).
#
# Environment Variables:
#     ENV: Propagates environment setting into the container.
#     BUILD_VERSION: Propagates build version into the container.
#     NODE_ENV: Set to match ENV for compatibility with Node-based tooling.
#
# Application files are copied into /usr/app, dependencies installed, and the service started using a shell script.
# """
FROM python:3.13.1-slim-bookworm

# Set up directories in advance so we can control the permissions
RUN mkdir -p /usr/app

# Set the work directory
WORKDIR /usr/app

# Copy over application files
COPY . .

# Set ARGs and ENV vars
ARG BUILD_VERSION
ARG ENV
ENV ENV=${ENV}
ENV BUILD_VERSION=${BUILD_VERSION}
ENV NODE_ENV=${ENV}

# Install dependencies
RUN pip install -r requirements.txt

# Start the service
CMD ["bash", "./start-service"]