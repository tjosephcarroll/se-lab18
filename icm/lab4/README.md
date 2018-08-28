## InterSystems Cloud Manager: Tuning Instances

ICM allows us to tune InterSystems IRIS instances

1. **Memory Tuning**
	1. Most of the time as InterSystems IRIS has a simple but effective affinity or *placement strategy* of containers-per-node of *distinct instance* because usually we are not interested in high-packing values for our containers -as we are after utilizing 100% of the resources at our disposal- then, we need to make sure our DM instance does indeed take advantage via the IRIS tuning parameters
		* ```
			"ISCglobals": "0,0,4000,0,0,0",
        	"ISCroutines": "64",
        	"ISCgmheap": "1048576",
        	"ISClocksiz": "134217728",
        	"ISCbbsiz": "1048576"
			```

---

2. **Storage Tuning**
	1. Depending on the application we would want to specify the storage capacity. In the following example we see two things:
		* (1) different data volume sizes and
		* (2) a different storage with higher IOPS
		* ```
			"DataVolumeSize": "40",
        	"DataVolumeType": "io1",
        	"DataVolumeIOPS": "1000",
        	"WIJVolumeSize": "10",
        	"Journal1VolumeSize": "20",
        	"Journal2VolumeSize": "20"
			```
	2. AWS Volume Types
		* ```
			standard    Magnetic                    1GB - 1024GB
			gp2	        General Purpose SSD         1GB - 16384GB
			io1	        Provisioned IOPS SSD        4GB - 16384GB
			st1	        Throughput Optimized HDD    500GB - 16384GB
			sc1         Cold HDD                    500GB - 16384GB
			```
	3. GCP Volume Types
		* ```
			pd-standard	Magnetic	1GB-64TB
			pd-ssd	    SSD	        1GB-64TB
			```
	4. Azure Volume Types
		* ```
			...
			```

---

3. **Let's Reprovision and Tune it**
	1. Remove the old cluster as we will be reprovisioning new storage type
		* ```# icm unprovision -stateDir ./ICM-0987654321 -cleanUp -force```
	2. Edit the *definitions.json* and let's add
		* Memory config and
		* Storage config as in the following *definitions.json* that you can also find as a complete file in this Github directory:
			- ```
				[
    				{
						"Role": "DM",
						"Count": "1",
						"LicenseKey": "ubuntu-sharding-iris.key",
						"ISCglobals": "0,0,4000,0,0,0",
        				"ISCroutines": "64",
        				"DataVolumeSize": "40",
        				"DataVolumeType": "io1",
        				"DataVolumeIOPS": "1000",
        				"WIJVolumeSize": "10",
        				"Journal1VolumeSize": "20",
        				"Journal2VolumeSize": "20"	
    				},
    				{
						"Role": "DS",
						"LicenseKey": "ubuntu-sharding-iris.key",
						"Count": "2",
						"StarCount": "10"
    				}
				]
				```
	3. re-provision the cluster again
		* ```# icm provision```
		* ```# icm run```
	4. connect to the instance and verify that the storage and the memory parameters were configured as requested.
		* ```# icm ssh -command "df -h" -role DM```
		* ```# icm session -interactive -namespace DB -role DM```
		* or alternative commands...

---

4. **Simpler Retuning**
	1. What if we just wanted to reconfigure some memory parameters?
		* Alter the values of *ISCglobals* and *ISCroutines* and then
		* Re-provision to refresh the *instances.json* with the new defaults & definitions JSON
			- ```# icm provision -stateDir ./ICM-0987654321```
		* Run an upgrade to regenerate the container (with Durable %SYS intact) with new iris.cpf params now applied
			- ```# icm upgrade -image intersystems/iris:2018.2.0-dev -role DM```
---

Congrats again :+1: 