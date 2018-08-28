## InterSystems Cloud Manager: Tuning Instances

ICM allows us to tune InterSystems IRIS instances

1. **Memory Tuning**
	1. Most of the time as InterSystems IRIS has a simple but effective affinity or *placement strategy* of containers-per-node of *distinct instance* because usually we are not interested in high packing values as we are after utilizing 100% of the resources at our disposal, then, we need to make sure our instance does indeed take advantage via the IRIS tuning parameters
		* ```
			"ISCglobals": "0,0,4000,0,0,0",
        	"ISCroutines": "64",
        	"ISCgmheap": "1048576",
        	"ISClocksiz": "134217728",
        	"ISCbbsiz": "1048576"
			```
	2. edit... 
	icm stop -role DM
	icm ps -container iris
	icm rm -role DM
	icm ssh -command "sudo rm -rf /irissys/*/*" -role DM
	edit definitions.json; add memory configuration
	icm run -role DM
	--failed
	--retried with: 
	icm run -stateDir ./ICM-906580582338591537/ -role DM
same Error

---

2. **Storage Tuning**
	1. Depending on the application we will definetely want to specify the storage capacity. In the following example we see two things:
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
			standard	Magnetic					1GB - 1024GB
			gp2	        General Purpose SSD 		1GB - 16384GB
			io1	        Provisioned IOPS SSD 		4GB - 16384GB
			st1	        Throughput Optimized HDD	500GB - 16384GB
			sc1	        Cold HDD					500GB - 16384GB
			```
	3. GCP Volume Types
		* ```
			pd-standard	Magnetic	1GB-64TB
			pd-ssd	    SSD	        1GB-64TB
			```
	4. Azure Volume Types
		* ```
			aaa
			```

---

3. **Let's Tune it**
	1. Remove the old cluster
		* ```# icm unprovision -stateDir ./ICM-0987654321 -cleanUp -force```
	2. Edit the *definitions.json* and let's add
		* Memory config and
		* Storage config as in the following *definitions.json* that you can also find as file in this Github directory:
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
		* ```icm session -interactive -namespace DB -role DM```
		* or alternative commands...

---
