# InterSystems Cloud Manager - Environment Setup

1. **Pull InterSystems Cloud Manager (ICM)**
    * Everything is pre-packaged for you in a container
    * You have nothing to install and configure
        * JVM
        * Terraforms
        * environment setup
        * samples
```
$ docker pull intersystems/icm:2018.2...
```

2. **ICM Automates the Environment**
The easiest way to get started with ICM is by using the /Samples/* as we saw in Lab0. we provide in the container. However, there are a couple of issues that could make their use a little uncomfortable (a) using vi inside the contianer and (b) loosing all your settings when exiting the cont
Many issues with ICM, like with anything "cloud", revolve around the corollary security setup needed, the correct privileges with accounts for useing IaaS resources, latency & timeouts, etc. We must think of it as an hostile environment by its nature wrt securoty and one that must be prepared. Everything comes to us early in the cloud. We do not control a cloud environemtn like we control and manage our latop. We are merely users of resources and we must adhere to the API at our disposal. We have tried to make things simpler and welcome your feedback. ICM & ISC help us in several ways. Let's get started:
    1. **Credentials** for the IaaS providers
        1. *AWS:* [link to corporate credentials valid for 12 hours](https://usconfluence.iscinternal.com/display/IAWS/AWS+Credentials+Utility+for+ICM+and+AWS+CLI) see the instructions (there is a further link to select and here is the [direct link](https://awscredentials.intersystems.com)
            * input your ISC SSO crendentials
            * click the "Get AWS Credentials" button from the "AWS Data Platform" central section
            * save those credential in a file
        2. *GCP*
            * student ID 
        3. *Azure*
            * ...
    3. **ssh keys**
        1. ICM can quickly create & use temporary keys for you by running a script
    5. **TLS certificates**
        1.  ICM can quickly create & use temporary certs for you by running a script
    7. **InterSystems license key**
        1. ICM can quickly prepare a key for us by running a script (be VPN'd in)

FYI
[ICM Getting started guide](http://steven...)
    
    

3. **Reusable Script Preparation** -
    1. Make sure you have your credentials for the selected public provider and that they are saved in a file. You'll have to tell ICM to grab that file.
    2. Don't worry about
        1. ssh keys
        2. TLS certs &
        3. InterSystems IRIS key - ICM supports you in your demo & POC efforts
    3. Create a working "cloud" directory. Let's call it 'cloud' and cd into it. For example
        a. ```$ mkdir $HOME/cloud```
        b. ```$ cd cloud```
    4. Copy your *credential file* to this cloud working directory; for example
    ```$ cp $HOME/Download/aws.credentials $HOME/cloud```
    5. Copy the *InterSystems IRIS license key* in the same cloud directory as above
    6. Create a subdir of the cloud directory called "key" that we will use later for all security related files
    ```$ mkdir $HOME/cloud/key```
    7. let's *prepare a script* to launch ICM so that we don't have to remember all the details of the docker command. Use *vi|vim|nano|emcas|editor-of-choice* and create a bash or powershell script called *icm.sh* and copy/paste the following code.

    ```
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
    ```
    
    8.  make sure that the ICM container *version* is the one you want
    9.  make sure the script can be executed
        a.  ```$ chmod icm.sh```
    10. run it
        a.```$ ./icm.sh``` 
    11. You should be inside the ICM container ready to run the ICM commands
        a. Check that your cloud directory was mounted ```ls -l```
        b. cd into it to verify that the content of the host dir is all there and that ICM responds
        ```
        # cd /cloud
        # ls -l
        # icm
        ```
    12. :+1: Congrats! ICM is ready to provision your cloud infrastructure and your script can be used again and again.
 

4. **Securities and Keys** -
    1. Instead of strating from scratch with our definitions we will *leverage the samples* provided, so, run the following command to copy & verify the ICM declarative definitions we want to use
    ```
    # cd /cloud
    # cp /Samples/AWS/*.json .
    # ls -l
    ```
    3. Create temporary *ssh keys* and store them in ./key 
    ```/cloud # keygenSSH.sh ./key/ ```
    5. Create temporary TLS certificates and again let's store them away in the ./key directory
    ```/cloud # keygenTLS.sh ./key/ ```
    7. Create temporary InterSystems IRIS key files (make sure you're VPN'd in) and copy them in the same /cloud/key location
    ```
    # getLicense.sh
    # cp /Samples/license/* ./key/
    # ls -l ./key
    ```
    9. FYI all executables and scripts provided by ICM are in your path and can be found in */ICM/bin*
    10. 
    11. bbb

5. **Infrastructure Definition**
    1. It's time to make sure our declarative JSON definitions are what we want to carve out of those clouds, so, with your favourite editor, open and edit the **defaults.json**. Please change: 
        a. Change the UPPERCASE values (Label & DockerUsername) 
        b. Review the Credentials localtion value
        c. Add a password for all your IRIS cluster instances (ISCPassword) 
        Hopefully the rest is in sync with your environment or adjust paths as per your environment setting
    ```
    {
    "Provider": "AWS",
    "Label": "MYINITIALS",
    "Tag": "t1",
    "DataVolumeSize": "10",
    "SSHUser": "ec2-user",
    "SSHPublicKey": "/cloud/key/insecure-ssh2.pub",
    "SSHPrivateKey": "/cloud/key/insecure",
    "DockerImage": "intersystems/iris:2018.2.0-dev",
    "DockerUsername": "MY-DOCKER_HUB_ID",
    "DockerPassword": "",
    "TLSKeyDir": "/cloud/key",
    "LicenseDir": "/cloud/key/",
    "Region": "us-west-1",
    "Zone": "us-west-1c",
    "AMI": "ami-18726478",
    "InstanceType": "m4.large",
    "Credentials": "./aws.credentials",
    "SystemMode": "TEST",
    "ISCPassword": "",
    "Namespace": "DB",
    "Mirror": "false"
    }
    ```
    3. ...


6. **IRIS Cluster Definition**
    1. While the *defaults.json* file is mostly concerned with the infrastructure side, the **definitions.json** specifies the type of InterSystems IRIS cluster we want. For this first run we are happy to just have this simple definition of 1xDM and 2xDS. There is nothing to do for you. Lucky guy :)
    ```
    [
      {
	    "Role": "DM",
	    "Count": "1",
	    "LicenseKey": "ubuntu-sharding-iris.key"
      },
      {
	    "Role": "DS",
	    "Count": "2",
	    "StartCount": "2",
	    "LicenseKey": "ubuntu-sharding-iris.key"
      }
    ]
    ```
    3. ...
     
7. AAA
8. BBB