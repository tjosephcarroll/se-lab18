# InterSystems Cloud Manager Lab0

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
The easiest way to get started with ICM is by using the /Samples/* we provide in the container.
Many issues with ICM, like with anything "cloud", revolve around the corollary security setup needed, the correct privileges with accounts for useing IaaS resources, latency & timeouts, etc. We must think of it as an hostile environment by its nature. We do not control it like we control and manage our latop. We are merely users of resources and we must adhere to the API at our disposal. We have tried to make things simpler and welcome your feedback. ICM & ISC help us in several ways. Let's get started:
    1. Credentials for the big 3
        2. AWS
            a. [link to corporate credentials valid for 12 hours](https://usconfluence.iscinternal.com/display/IAWS/AWS+Credentials+Utility+for+ICM+and+AWS+CLI) see the instructions (there is a further link to select)
                * [direct link](https://awscredentials.intersystems.com)
            b.input your ISC SSO crendentials
            c. click the "Get AWS Credentials" button from the "AWS Data Platform" central section
            d. save those credential in a file
        4. GCP
            a. student ID 
        6. Azure
            a. ...
    3. ssh keys
        1. ICM can quickly create & use temporary keys for you by running a scipt
    5. TLS certificates
        1.  ICM can quickly create & use temporary certs for you by running a script
    7. InterSystems license key
        1. ICM can quickly prepare a key for us by running a script (you must be VPN'd in)

FYI
[ICM Getting started guide](http://steven...)
    
    

3. **Let's Run** -
If you have saved your AWS credentials from the above 
5. **BBB** -

// picture
![](https://)

// URL link
[ISC](https://www.intersystems.com)
