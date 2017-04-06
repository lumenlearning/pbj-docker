#!/bin/bash

docker rmi pbj_install_wordpress

docker build -t pbj_install_wordpress .

