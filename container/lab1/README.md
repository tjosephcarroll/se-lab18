# Building your own Container

There are 2 ways to create a container image.
Points (a) and (b) below allows us to test these 2 methodologies


**a)**
run a container,
stop it,
commit the changes done to a new one.

Let's try it out:
- we will run a container and jump in the internal shell
- we will then create a file
- then exit the container
- and create a new **container image**, with our file in it, from the one that was just stopped.

Commands to execute at the OS command prompt
```
$ docker run -i -t busybox sh           // i = interactive; t = pseudo tty

# touch myfile.test                     // create an empty file

# ls -l                                 // verify the file exists

# exit

$ docker ps                             // No container available

$ docker ps -a                          // I can see an exited/stopped container

$ docker commit <CONTAINER_ID> <MY-REPO>:<MY-TAG>
// replace <VARS> with your specific container ID and
// a repo name and tag of your liking like fred:v1 for example (lower case only)

$ docker images                         
// verify that your new container image is available in your local repo
```

---



**b)**
The real deal is via a build process that can be automated.
The build process starts with the declaration state -in a *Dockerfile*, of what we want our container image to be and contain. The build process allows us to satisfy any application dependencies at BUILD time (vs RUN time).

We will build an app and package it up in a container that we can then run anywhere.

1. **Let's create an App** - 
Copy & paste the following code in a file called server.js (it's javascript for Node.js but it could have been as easily GO, Python, etc.)
```
var http = require('http');
var handleRequest = function(request, response) {
  response.writeHead(200);
  response.end("Hello World!");
}
var www = http.createServer(handleRequest);
www.listen(8080);
```

or simply copy/paste from Github or clone this lab so that at the end you have a *server.js* file.

2. **Node.js** -  
If you have Node.js installed test your app or
install Node.js and test it :)
https://nodejs.org/en/download/

Let's launch the app via
```
$ node server.js
```

and verify it works with a browser or another shell with 
```
$ curl http://127.0.0.1:8080
```

You can now stop Node.js with a CTRL-C on the terminal where you launched it.


3. **Creating the Container Definition** - 
Instead of running a container and copying things in the container and committing it to a new container image, as in the previous exercise, we will automate its creation via the Docker build command and simply provide the declaration of what we want in the container and what should be running.

The following is the container declaration to copy & paste in a file called *Dockerfile*.
```
# deriving our container from a prebuilt one
FROM node:10-slim

COPY server.js .

EXPOSE 8080

# run the following default command when container is run
CMD node server.js
```
You'll have noticed that we did not install Node.js but just inherited or derived our image FROM an existing one.

Please try a quick lookup of available Node.js containers via
```
$ docker search node
```

What do you see?

For this exercise, again you can simply copy/paste from this Github page or clone this lab so that at the end you have a Dockerfile file as per example.


4. **Building the Container** - 
After the definition in the Dockerfile, let's build it
```
$ docker build -t service:v1 .
```

After the build check that effectively you have a new container image
```
$ docker images
```

also investigate all the container layers via
```
$ docker history service:v1
```

5. **Running the new Container** - 
Let's run the container
but before we do that let's do some housekeeping just in case
* First, list all running containers
```
$ docker ps
```

* Second, list all stopped containers
```
$ docker ps -a
```

* Third, stop all running containers and remove all stopped containers too as they still hold resources like open sockets etc.
```
$ docker stop $(docker ps -aq)

$ docker rm $(docker ps -aq)
```

* Fourth, Now that we have been diligent with our housekeeping, we can run our app
```
$ docker run -d --name myservice -p 8080:8080 service:v1
```

* Fifth, now check that it is running and that we can access our service at the http end-point
```
$ docker ps
```

What details do you see?

```
$ curl http://127.0.0.1:8080
or
via your browser
```

Stop & remove the container
```
$ docker stop myservice

$ docker ps

$ docker ps -a

$ docker rm my service
```

6. **Push it** - 
Now that we have the app service packaged up, let's push it to our personal container repository for sharing it or pulling it from a cloud node.
We will use our individual user accounts on Docker Hub and push our *service:v1* container image to that account

* make sure you're logged in via
```
$ docker login -u=<USERNAME>

or to make sure we address the right registry -although it's the default, try
$ docker login docker.io -u <USERNAME> 
```

* Move the local container image to the personal registry. Remember that by default container images pushed to Docker Hub are public. You can have private registry but you have to pay.
* A simple docker push will most probably fail as the container must be named according to your registry.
    * at present we have a simple *service:v1*
    * The individual account on Docker Hub contains our Docker ID so we need to rename or re-tag our image first before Docker knows where to upload it to
```
$ docker tag service:v1 <MY_DOCKER_ID_NAME>/service:v1
```

Now, after the retagging you can push it
```
$ docker push <MY_DOCKER_ID_NAME>/service:v1
```

---

Congrats! You're now a container expert that can pull, run, build & push containers and 
use the same operational commands on most modern platforms: 
* x86-64 Linux (Ubuntu, RHEL, SUSE, Debian, Fedora, etc.)
* ARM (Android, Rasperry PI, Arduino, microcontrollers, etc.)
* Windows
* IBM 
	- POWER & 
	- Z mainframe architectures

	
