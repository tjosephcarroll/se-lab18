# InterSystems Cloud Manager - Elasticity

1. **Add Shard Instances to the Cluster**
    1. Let's say we are reached capacity and we need to scale horizontally with more shard nodes. Let's add 2 more node and test the ICM configure it all correctly.
    	* Edit the *configurations.json* file and increase the SD count to 4
    	* Reprovision your cluster
    		- ```# icm provision -stateDir ./ICM-0987654321```
    	* Run the deployment again
    		- ```# icm run```

---

