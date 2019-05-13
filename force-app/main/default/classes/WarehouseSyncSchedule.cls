global class WarehouseSyncSchedule implements Schedulable {
    // implement scheduled code here
    global void execute(SchedulableContext sc) {
        //calling sync method of warehouse class
        WarehouseCalloutService.runWarehouseEquipmentSync();
    }
    
    /*	//Run this from dev console execute Anonymous
     	WarehouseSyncSchedule wcallout = new WarehouseSyncSchedule();
        String cronExp ='0 0 1 * * ?';
        String jobName = 'Warehouse Callout';
        String jobId = System.schedule(jobName, cronExp, wcallout);
	*/
}