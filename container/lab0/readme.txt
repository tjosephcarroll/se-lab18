LOCAL ENVIRONMENT SETUP

1)
Register with an id of your liking at
https://hub.docker.com/
and send me your DockerID so that I can add you to our org registry

2)
Download and install Docker-for-Mac or Docker-for-Windows on your laptop, respectively from
https://docs.docker.com/docker-for-mac/install/
or
https://docs.docker.com/docker-for-windows/install/
for Windows users: the install will ask you about Hyper-V. You will need that to run normal, standard (Linux) containers. You may encounter issues if you use VMware. Some people do not have any issues, some struggles. YMMV.


More specific info can be found here:
https://community.intersystems.com/post/using-intersystems-iris-containers-docker-windows

However, we are changing things and making things easier for your in respect to storage-drivers and keys.

3)
Bonus extra, make sure it all works with a simple run command
$ docker run --rm busybox echo 'hello world'
// docker run:run a container
// --rm: remove it from the stack of stopped containers when done; be diligent and clean and you won’t have issues ☺
// busybox: run the container called busybox, one of the smallest containers the size of 1.1MB
// echo argument: run the command echo

If you see the string output you have a successful Docker container environment on your laptop.
Congrats!

4)
For more info and issue resolution on Docker containers please see our internal Container Port
https://usconfluence.iscinternal.com/display/TBD/Containers+Port
--
