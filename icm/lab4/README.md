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

---
