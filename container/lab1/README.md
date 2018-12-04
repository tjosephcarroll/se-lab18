# Running Your First IRIS Container

0. **Requirements** 
    * If you have not completed Lab0 please do so here https://github.com/tjosephcarroll/se-lab18/tree/master/container/lab0

1. **Container Registries**

    * Now that we know what a container is let's see how we can get the official containers from InterSystems or how we can pull them from our registries. There are 2 container registries to be aware of:

    a. https://docker.iscinternal.com
      * That is the InterSystems private & internal Docker registry which you will need to be able to access in order to pull pre-released images. Think of it as our kitserver for the std tarballs. This registry requires you to log in in order to pull down images. Having your raw password stored in a plain text file would be unsafe.  So the process requires that you put in an encrypted form of your password that you get through the GUI at docker.iscinternal.com. Instructions on accessing InterSystems internal private container registry: 
          * Make sure you are connected & within the InterSystems VPN or otherwise on the ISC network. 
          * In a browser, go to https://docker.iscinternal.com
          * Log-in using your regular iscinternal SSO username without the domain (for example, use ‘mywindowslogin’, not 'iscinternal/mywindowslogin' or 'iscinternal\mywindowslogin'), and your usual domain password
          * In the right upper corner of the browser page, click on your user name, which will have a pull-down menu underneath it
          * Choose *Account Settings* from the pull-down menu
          * In the *Docker CLI Password* section of the page, click *Generate Encrypted Password*
          * Enter the SSO/domain password you used to log-in in step 1 
          * From the new panel that appears, titled *Credentials for <yourUserName>*, click *Docker Login*. You will see a command line for docker login displayed.
          * Open a terminal session on the computer where you will be running docker commands, logged in as the user who will run them
          * In the terminal session, run the docker login command copied from the browser.  This will update your $HOME/.docker/config.json file, embedding this encrypted password into that file.
Now you can run the normal docker pull command, such as:
  * ```$ docker pull docker.iscinternal.com/intersystems/iris:2018.2.0.454.0```


    b. docker.io
      * https://hub.docker.com/
      * https://store.docker.com/
      * The above are respectively the OSS & enterprise/EE-certified/commercial Docker container registries
      * We registered the "intersystems" organization name
      * We should soon be using the Store for our EE certified image + eval, developer, express...
      * At present you can view & pull from the private registry if you have given us your Docker ID
      * see the "Private Registry Access" section of https://usconfluence.iscinternal.com/display/TBD/Containers+Port

2. **Pull down the IRIS Container Image** 

    * Now that you have access to the repository it is time to pull down the container image in preparation for running it. To do this we will use the "docker pull" command. 
        * ```$ docker pull docker.iscinternal.com/intersystems/iris:2018.2.0-stable```
    * This command contacts the container registry, finds the container image, and pulls a copy of it down to our host machine.

3. **Create an IRIS Container** 
    * Now that we have the IRIS image locally we can create a container from this image. To do this we will use the "docker create" command. It has many options, but we're going to keep it simple for now.

    * ```$ docker create --name iris docker.iscinternal.com/intersystems/iris:2018.2.0-stable```
    * Here's a breakdown
        * docker create <optional_flags> <image_name>, this tells the docker engine we want a container
        * --name iris, optional flag that names our container "iris"
        * docker.iscinternal.com/intersystems/iris:2018.2.0-stable, the name of the image we want to create a container from.

4. **Start the IRIS Container** 
    * ```$ docker start iris```

5. **Check that the container is running**
    * ```$ docker container ps```

6. **Enter the running container**
    * ``` docker exec -it iris bash ```
    * Breakdown
        * docker exec <optional_flags> <container_name> <command_to_execute>, creates a process in the container to execute a command
        * -it, optional flags that make the command interactive (i) and give us a TTY (t)
        * iris, you named the container this in step 3
        * bash, the command to execute, a bash shell

7. **Check that IRIS is running**
    * You now are inside the container at a bash, check that iris is running. (Warn state is ok, you haven't licensed the instance)
    * ```$ iris list```

8. **Check the list of process and see that the container is isolated**
    * Containers are isolated by default. Listing the processes inside the container will only show you the processes of your container. In this case you will see IRIS processes and your bash shell.
    * ```$ ps -ef```

9. **Write a file in your container**
    * We saw in 8 how processes are isolated, but what about the file system? Create a file with the touch command in the root directory of your container.
    * ```$ touch today_is_12_5_2018.txt```

10. **Exit your container**
    * ```$ exit```

11. **Where is your file?**
    * The file you created in 9 **only** exists inside that container and cannot be (easily) accessed from the host machine.

12. **Repeat steps 2 through 6 chosing the container name iris_v2**
    * Here we are mocking an update to the container perhaps in the application code or the underlying version of IRIS.
    * Does your file exist in the new container? (Hint: no)
    * Since IRIS is a database platform, we need to handle this problem. We will in Lab2 