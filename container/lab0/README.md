# LOCAL ENVIRONMENT SETUP


1) Download and install Docker-for-Mac or Docker-for-Windows on your laptop, respectively from
https://docs.docker.com/docker-for-mac/install/
or
https://docs.docker.com/docker-for-windows/install/
for Windows users: the install will ask you about Hyper-V. You will need that to run normal, standard (Linux) containers. You may encounter issues if you use VMware and as you switch. Some people do not have any issues, but sometimes there are problems. More specific info can be found here:
https://community.intersystems.com/post/using-intersystems-iris-containers-docker-windows
or install the Docker engine on a Linux VM.

Do not change your Docker CE storage-driver and keys.

3) Make sure it all works with a simple run command executed from the Terminal, bash, or cmd line.
```

$ docker run --rm busybox echo 'hello world'
```
* What the above means:
	- docker run: pull, create, and start a container
	-  --rm: remove it from the stack of stopped containers when done
be diligent and clean and you won’t have issues ☺
	- busybox: run the container called busybox, one of the smallest containers the size of 1.1MB
	- echo argument: once the container is started, run the command echo

If you see the string output you have a successful Docker container environment on your laptop.
Congratulations.

4) For more info and issues resolutions on Docker containers please see our internal Container Port at:
https://usconfluence.iscinternal.com/display/TBD/Containers+Port

5) If you cannot get it working in time, I will have back up VMs.

---
