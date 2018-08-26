# InterSystems Cloud Manager First Steps

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
---

2. **ICM Automates the Environment**
The easiest way to get started with ICM is by using the /Samples/* we provide in the container. In this lab we'll start getting familiar with pure container environment and with all the facilities it offers us, especially for SEs. W
    1. Run the ICM container 
        1. ``` $ docker run -it --cap-add SYS_TIME intersystems/icm:2018.2.0-dev```
    3. Explore the container, where are Samples? And the binaries?
        1. check the environemnt
        2. ``` # env```
        3. ``` # ls -l /```
---

3. **Samples**

    1. The various cloud providers samples can be found under */Samples*.
        1. For this first *getting comfortable with ICM* let's settle for the AWS provider.
        2. ``` # cd /Samples/AWS```
        3. Please check the files you have in the directory

---

4. **Pre-Run Prerequisites**
    1. **SSH Keys**. As stated, security was not an after thought and so we are forced or guided to do the right thing. ICM helps us in setting up a temporary security environmen so that we can get up and running quickly. Of couse, an organization would help its employees to sort out, create and manage *ssh keys*.
        1. ``` # keygenSSH.sh```
    2. **TLS Certificates**. ICM can also setup tem TLS certs
        1. ``` # keygenTLS.sh```
    3. **InterSystems Key**. ICM can also aids you in running demos quickly by providing you with the right licenses. The only requirement is that you are VPN-connected to the InterSystems network. As you know, as an SE you can use some temporary keys.
        1. ``` # getLicense.sh```
    4. **Credentials** We just need this last step before we are ready to provision our first cloud infrastructure. We won't go into the details of this option as we'll leave it for the next lab. We'll look at setting up a more appropriate environment, and perhaps one to share and talk over with prospects and customers. In the meantime, let's check some basics to make sure ICM is installed and running correctly
        1.  ``` 
            # icm version
            # icm --help
            # icm
            ```

---

Congrats! :+1: This was a first quick lab to make you comfortable with the ease of use and intuitiveness of InterSystems Cloud Manager and the utilities it provides out of the box for you. 