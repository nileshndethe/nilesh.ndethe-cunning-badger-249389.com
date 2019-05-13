trigger MaintenanceRequest on Case (before update, after update) {
    // call MaintenanceRequestHelper.updateWorkOrders  
    if(Trigger.isUpdate && Trigger.isAfter){
        
        Set<Id> caseIdSet = new Set<Id>();
        
        for(Case cse : Trigger.New){
            Case oldCase = (Case)Trigger.OldMap.get(cse.Id);
            if(cse.Status == 'Closed' && cse.Status != oldCase.Status && (cse.Type == 'Routine Maintenance' || cse.Type == 'Repair')){
                caseIdSet.add(cse.Id);
            }
        }
        
        if(caseIdSet.size() > 0){
            MaintenanceRequestHelper.updateWorkOrders(caseIdSet);
        }
    }
}