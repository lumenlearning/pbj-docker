#!/bin/bash

docker rmi pbj_redis

docker build -t pbj_redis .

