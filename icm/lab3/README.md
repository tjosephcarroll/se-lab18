## InterSystems Cloud Manager Container Management Commands

ICM allows us to manage any other type of container with the *-docker* flag. IOW ICM allows us to pass-through, all the way to the cloud compute -node, a Docker command, effectively letting us run any container. This is a very powerful feature and it's the cornerstone of **composable architecture**. Also, it is worth noting how ICM does not have its own set of commands for stopping removing, pulling and running services (containers) and uses the same verbs found with Docker, Github and similar.

1. **Stopping Services**
	1. You can stop any service (running container) via the *icm stop* command. To stop the default IRIS container on a specified AM node try: 
		* ```# icm stop -machine LR-r2-AM-test-0004```
	2. To stop a Sysdig monitoring-agent container in all SD nodes the code would be:
		* ```# icm stop -container sysdig -role SD```

---

2. **Removinga Service**
At times we just want to get rid of a container image all together because we upgraded the system or it's a service we don't want to use anymore and we want to be good housekeepers and look after our storage
		* Removing a stopped container
		```# icm rm -container signalfx -machine mename-r3-SD-test-0001```

---

3. **Pulling Images** 
When we want to perform an upgrade of a container we need to make sure we have the version we want. In Docker terminology this is a *pull* operation (the lingo is very Githubish)
		* Pulling a new container image before a subsequent run to a specific machine or tier (identified by role names)
		```# icm pull -image intersystems/iris:2020.1 -role DM```

---

4. **Starting & Runnig Services for a Composable Architecture**
We can obviously start any service we might want. When working with containers it is natural to start thinking in terms *services or utilities* or libraries as yet another container to run. Things just become simpler as there is no installation and configuration to worry about but only an end-point to fire up & leverage
		* Starting a container on a tier of servers
		```# icm start -container sysdig -role SD```
---

5. **Upgrading a Cluster**
	1. ICM also provides a command to upgrade the whole InterSystems IRIS cluster without having to issues all the commands above. ICM runs all the following operations for us:
		1. Pulls the image
		2. Creates the new container
		3. Stop the existing container
		4. Remove the existing container
		5. Start the new container
		```# icm upgrade -image intersystems/iris:2021.1.2```

or to upgrade a specific service role (or tier)

```# icm upgrade -image intersystems/iris:2021.1.3 -role QS```

The standard *ICM ps* command will reveal a new version running
```
# icm ps -container iris

Machine               IP Address     Container Status Health  Image
-------               ----------     --------- ------ ------  -----
Acme-DS-TEST-0004     54.201.52.145  iris      Up     healthy isc/iris:stable
Acme-DS-TEST-0003     54.213.27.49   iris      Up     healthy isc/iris:stable
Acme-DM-TEST-0001     54.187.135.199 iris      Up     healthy isc/iris:stable
Acme-QS-TEST-0002     54.191.29.125  iris      Up     healthy isc/iris:2021.1.3 <--
```

---









