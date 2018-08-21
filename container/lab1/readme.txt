BUILDING YOUR OWN CONTAINER

There are 2 ways to create a container image.
Points (a) and (b) below allows us to test these 2 methodologies

a)-------------
run a container
stop it
commit it to a new one

let's try it out:
- we will run a container and ask to run in the internal shell
- we will then create a file
- then exit the container
- and create a new **container image**, with our file in it, from the one that was just stopped.

Commands to execute at the OS command prompt 
$ docker run -i -t busybox sh		// i = interactive; t = pseudo tty

# touch myfile.test			// create an empty file

# ls -l					// verify the file exists

# exit

$ docker ps -a				// pick up the container ID

$ docker commit CONTAINER_ID MY-REPO:MY-TAG 
// replace uppercase vars with your specific container ID and invent a repo-my-name:v1 for example

$ docker images				// verify that your new container image is available in your local repo




b)-------------
The real deal is via a build process that can be automated.
The build process starts with the declaration state -in a Dockerfile, of what we want our container image to be and run
and allows us to satisfy any application dependencies at BUILD time (vs RUN time)


1) 
Let's create an App,
copy & paste the following code in a file called server.js
--
var http = require('http');
var handleRequest = function(request, response) {
  response.writeHead(200);
  response.end("Hello World!");
}
var www = http.createServer(handleRequest);
www.listen(8080);
--

or simply copy/paste from Github or clone this lab so that at the end you have a server.js file


2)
If you have Node.js installed test your app or
install Node.js and test it :)
https://nodejs.org/en/download/

launch your app via
$ node server.js

and via a browser or another terminal call your end-point
(curl) http://127.0.0.1:8080


3)
We now want to create the container with our app and all its dependencies (in our case just Node.js + our code in server.js).
Instead of running a container by handi, as in the previous exercise, and copying things in the container and committing it to a new container image, we will automate its creation via the Docker build command and simply provide the declaration of what we want in the container and what should be running.
 
The following is the container declaration to copy & paste in a file called Dockerfile.
You'll notice that we won't install Node.js but just inherit or derive our image FROM an existing one.

Please try a quick lookup of available node.js containers via
$ docker search node

What do you see?

The Dockerfile definition to copy paste in a file named Dockerfile
--
# deriving our container from a prebuilt one
FROM node:10-slim

COPY server.js .

EXPOSE 8080

# run the following default command when container is run
CMD node server.js
--

or simply copy/paste from Github or clone this lab so that at the end you have a Dockerfile file



4)
After the definition let's build it

$ docker build -t nodejs:v1

After the build check that effectively you have a new container image
$ docker images

also investigate all the container layers via
$ docker history nodejs:v1

5)
Let's run the container
but before we do that let's do some housekeeping just in case
First
we'll list all running containers
$ docker ps

Second
we'll list all stopped containers
$ docker ps -a

Third
We'll stop all running containers and remove all stopped containers too as they still hold resources like open sockets etc.
$ docker stop $(docker ps -aq)

$ docker rm $(docker ps -aq)

Fourth
Now that we have been diligent with our housekeeping, we can run our app
$ docker run -d --name node -p 8080:8080 nodejs:v1

check that we can access the http end-point
$ curl http://127.0.0.1:8080
or
via your browser


Congrats!
