#!/bin/bash
clear

# extract the basename of the full PATH
DIR2MOUNT=$(basename $(pwd))

# we are mounting the PWD or $HOME/cloud (for example) inside the container 
# at the root level.
# IOW we will have '/cloud' in the container 
# with all the files found at the host level in $HOME/cloud
#
docker run --name icm -it -v $PWD:/$DIR2MOUNT --cap-add SYS_TIME intersystems/icm:2018.2.0-dev

printf "\nExited icm container\n"
printf "\nRemoving icm container...\nContainer removed:  "
docker rm icm
