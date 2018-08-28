# InterSystems Cloud Manager - Elasticity

1. **Add Shard Instances to the Cluster**
    1. Let's say we are reached capacity and we need to scale horizontally with more shard nodes. Let's add 2 more node and test the ICM configure it all correctly.
    	* Edit the *configurations.json* file and increase the SD count to 4
    	* Reprovision your cluster
    		- ```# icm provision -stateDir ./ICM-0987654321```
    			* LR-DS-TEST-003
    			* LR-DS-TEST-004
    		
    	* Run the new services or instances in the new nodes
    		- ```# icm run -machine LR-DS-TEST-003```
    		- ```# icm run -machine LR-DS-TEST-004```

---

2. **Add AM Roles**
	1. Add AMs
	2. Elastically grow the tier

---

3. **Add QS Roles**
	1. Add QSs
	2. Elastically grow the tier

---


