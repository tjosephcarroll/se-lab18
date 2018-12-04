#!/bin/bash

CONTAINER_IMAGE=docker.iscinternal.com/intersystems/iris:2018.2.490.0

# Container run with the IRIS Durable %SYS feature: systems settings will be persisted across containers re-start & upgrade
# Note on args:
# -p for port mapping
# -v volume (bind mount) of $PWD for the key and for the persistent or durable %SYS
# -e env var ISC_DATA_DIRECTORY, IRIS specific var for Durable %SYS feature https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=ADOCK#ADOCK_iris_durable
# -h host name
# --name for container name
# --init ghost reaper
# --cap-add linux kernel capabilities, allow for memory pinning

# the docker run command
docker run -d \
  -p 9091:51773 \
  -p 9092:52773 \
  -p 9093:53773 \
  -v $PWD:/ISC \
  -e ISC_DATA_DIRECTORY=/ISC/iris_conf.d \
  -h iris \
  --name iris \
  --init \
  --cap-add IPC_LOCK \
  $CONTAINER_IMAGE \
  --key /ISC/iris.key \
  --log $ISC_PACKAGE_INSTALLDIR/mgr/messages.log
