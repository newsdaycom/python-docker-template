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

# If this is a prod environment, package the code
RUN if [ "$ENV" != "local" ]; then yarn build; fi

# Start the service
CMD ["bash", "./start-service"]
