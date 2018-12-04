# Running InterSystems IRIS container

1. **Container Registries** - Now that we know what a container is (how to run one and how to build one) let's see how we can get the official containers from InterSystems or how we can pull them from our registries. There are 2 container registries to be aware of:

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



2. **Super Quick IRIS Test** - For quick testing there is no need to run a full durable or persistent container (%SYS and your DB). Let's say you just want to try out few things with a new InterSystems IRIS version, you can just fire up the container with minimum params as in
```
$ docker run -d -p 52773:52773 intersystems/iris:2018.2.0.454.0
```
or view and run the script run-1-SuperQuick.sh


3. **Ephemeral IRIS Test** - For more in depth testing and maybe even mount some databases, we might still want to run in an ephemeral mode. We are still *not concerned with retaining system settings* like user-credentials, security switches, application definitions and ZSTU code but we might want to connect with Studio or Atelier, view some code on a database, and do development on another.
View and run the script run-2-Ephemeral.sh
    * View and run the script *run-2-Ephemeral*
    * you will need an *iris.key* to operate appropriately from this stage

4. **Full Durable IRIS** - At this stage we are either developing, testing or running in pre-production or production mode with the Durable %SYS feature, effectively running with all persistent capabilities and behaving as a first-class citizen of the container world.
    * We want to make sure we retain IRIS system setting over container re-starts or upgrade, and therefore we need to implement the Durable %SYS feature
        * check the ISC_DATA_DIRECTORY (InterSystems specific) env var; it's a flag and a pointer
        * check that there is a corresponding bind mounted volume [-v | --volume | --mount]
        * view & run the script *run-3-DurableSYS.sh*



---


Congrats! :tada: You now know how to run InterSystems IRIS Data Platform containers with the various Docker and IRIS options. :tada:
