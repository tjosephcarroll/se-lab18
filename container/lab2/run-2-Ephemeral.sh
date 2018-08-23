#!/bin/bash

CONTAINER_IMAGE=docker.iscinternal.com/intersystems/iris:2018.2.0.454.0

# Ephemeral container: no state will be saved (no Durable %SYS)
# Note on args:
# -p port mapping
# -v volume (bind mount) of $PWD for the key
# --name for container name
# --init ghost reaper

# the docker run command
docker run -d \
  -p 51773:51773 \
  -p 52773:52773 \
  -p 53773:53773 \
  -v $PWD:/ISC \
  --name iris \
  --init \
  $CONTAINER_IMAGE \
  --key /ISC/iris.key \
