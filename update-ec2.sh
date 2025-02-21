#!/bin/bash
docker stop timeoff-app || true
docker rm timeoff-app || true
docker pull $1
docker run -d -p 3000:3000 --name timeoff-app $1
