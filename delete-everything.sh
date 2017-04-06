#!/bin/bash

docker-compose down

docker images | grep pbj | awk '{print $1}' | xargs docker rmi

