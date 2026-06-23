# Purpose:
#   Build the runtime image for Newsday Python services generated from this
#   template.
#
# Usage:
#   docker build \
#     --build-arg ENV=local \
#     --build-arg BUILD_VERSION=local-build \
#     -t python-docker-template:local .
#
# Environment:
#   ENV identifies the runtime environment copied into the image.
#   BUILD_VERSION identifies the release or local build copied into the image.
#
# Operational Notes:
#   Dependencies are installed before application files so Docker can reuse the
#   dependency layer when only source files change.
FROM python:3.13.1-slim-bookworm

# Prevent Python from writing .pyc files into bind-mounted local source trees.
ENV PYTHONDONTWRITEBYTECODE=1

# Flush Python logs directly to stdout/stderr for Docker log collection.
ENV PYTHONUNBUFFERED=1

# Build arguments provide safe defaults for local template validation.
ARG BUILD_VERSION=local-build
ARG ENV=local

# Runtime environment variables are available to the Python entry point.
ENV BUILD_VERSION=${BUILD_VERSION}
ENV ENV=${ENV}

# Keep application code in a predictable path shared by Compose bind mounts.
WORKDIR /usr/app

# Install dependency metadata first to preserve Docker build-cache efficiency.
COPY requirements.txt .
RUN python -m pip install \
    --disable-pip-version-check \
    --no-cache-dir \
    --root-user-action=ignore \
    -r requirements.txt

# Copy the remaining application, documentation, and helper files.
COPY . .

# Delegate startup to the script so generated services can add preflight checks.
CMD ["bash", "./start-service"]
