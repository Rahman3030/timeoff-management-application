# -------------------------------------------------------------------
# Minimal dockerfile from alpine base
#
# Instructions:
# =============
# 1. Create an empty directory and copy this file into it.
#
# 2. Create image with: 
#	docker build --tag timeoff:latest .
#
# 3. Run with: 
#	docker run -d -p 3000:3000 --name alpine_timeoff timeoff
#
# 4. Login to running container (to update config (vi config/app.json): 
#	docker exec -ti --user root alpine_timeoff /bin/sh
# --------------------------------------------------------------------
FROM node:14-bullseye-slim
# Install system dependencies
RUN apt-get update && apt-get install -y python3 build-essential libsqlite3-dev

# Set Python 3 for node-gyp
RUN npm config set python python3

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm remove node-sass && npm install node-sass@^6.0.0 --legacy-peer-deps
RUN npm install --legacy-peer-deps

# Copy app source
COPY . .

EXPOSE 3000
CMD ["npm", "start"]

