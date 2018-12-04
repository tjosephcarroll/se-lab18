# Persisting IRIS Data and Configuration with Containers

1. **Create and start new container with a volume mapping**
    * Volumes are shared directories between the container and the host machine.
    * **Make sure that the permissions of the host volume are correct. If not you will not be able to write to them.**
    * ```docker create --volume <path_to_host_directory>:<path_to_container_directory> --name irisvolumetest docker.iscinternal.com/intersystems/iris:2018.2.0-stable```
    * ```docker start irisvolumetest```

2. **Make a write to your volume**
    * Enter the container
        * ```docker exec -it irisvolumetest bash```
    * Make a write to a file
        * ```touch test_write.txt```
    * Exit the container
        * ```exit```

3. **Stop your container**
    * ```docker stop irisvolumetest```

4. **Check that the data exists on the host**
    * You will look at whatever directory location you picked for the host in step 1.

5. **Create and start a new container with the same volume mapping**
    * Be sure to pick the same host directory as you did in step 1.
    * ```docker create --volume <path_to_host_directory>:<path_to_container_directory> --name irisvolumetest2 docker.iscinternal.com/intersystems/iris:2018.2.0-stable```
    * ```docker start irisvolumetest2```

6. **Check that the data is available inside the new container**
    * Enter the container
        * ```docker exec -it irisvolumetest2 bash```
    * Check that the file exists in the directory you picked for the container in action 5. If it isn't there it is user error ;)
    * Exit the container
        * ```exit```
7. **Set up Durable %SYS**
    * Instead of mapping a test directory outside fo the container. Let's create one for the IRIS configuration that we want to persist and pass in the environment variable letting IRIS know to move things there. 
    * We will also add port mappings here for convience (so that after this lab you can use the SMP and Studio/Atelier).
        * The publish command works like volume, ```--publish <host_port>:<container_port>```, and will do port forwarding. 
    * **Make sure that the permissions of the host volume are correct. If not you will not be able to write to them and this will fail.**

```docker create --publish 3000:52773 --publish 3001:51773 --volume ~/volume_host:/volume_container --env ISC_DATA_DIRECTORY=/volume_container/config --name iris182 docker.iscinternal.com/intersystems/iris:2018.2.0-stable```

```docker run iris182```

8. **Confirm that the IRIS configuration is persisted on the host**
    * Look in ~/volume_host or wherever location you chose for the host in step 7 to make sure the Durable %SYS directory is there.