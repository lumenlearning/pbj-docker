#!/bin/bash

apachectl restart

# If apachectl failed, terminate this script and allow Docker to restart this container.
if [ $? -gt 0 ]; then
	exit
fi


while true; do
	sleep 60
done
