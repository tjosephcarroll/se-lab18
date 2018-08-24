ICM lab1

3. **ICM Proper** - **THIS IS FOR LAB1**
    * Because ICM operates in a container we need to take care of not loosing the state 
    * It is typical with provisioning tools to work within a main directory where all infrastructure-as-code (IaC) declarations are found right there or in subdirectories
    * Therefore, one useful suggestion is to have the working directory and other files mapped to a host directory and literally use the ICM container as the carrier of the code (sepration of concerns between code & data). Literally this means mapping a host "cloud" directory for our provisioning and bind mount it in the ICM container so that all the most important files are found in the host dir. It sounds more complicated than it is:
        - defaults.json and
        - definitions
        - icm.sh     // utility to start the ICM container
        - ssh keys
        - TLS certificates
        - 

4. **Cloud Environment** - 
5. **aaa** -