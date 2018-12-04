#!/bin/bash

CONTAINER_IMAGE=docker.iscinternal.com/intersystems/iris:2018.2.0.490.0

# please note:
# No default container name
# No IRIS key
#

# the docker run command
docker run -d -p 52773:52773 $CONTAINER_IMAGE 
