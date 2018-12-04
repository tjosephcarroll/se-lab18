#Running Your First IRIS Container

0. **Requirements** - If you have not completed Lab0 please do so here https://github.com/tjosephcarroll/se-lab18/tree/master/container/lab0

1. **Container Registries** - Now that we know what a container is let's see how we can get the official containers from InterSystems or how we can pull them from our registries. There are 2 container registries to be aware of:

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

