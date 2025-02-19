#!/bin/bash

# Stop the existing Docker container
docker stop timeoff-app || true

# Remove the old container
docker rm timeoff-app || true

# Pull the latest Docker image
docker pull rahman303/timeoff-app

# Start the new container
docker run -d --name timeoff-app -p 3000:3000 rahman303/timeoff-app
