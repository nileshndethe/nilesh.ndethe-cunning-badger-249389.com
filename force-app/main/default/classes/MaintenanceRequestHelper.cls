public class MaintenanceRequestHelper {
    
    // update workorders
    public static void updateWorkOrders(Set<Id> caseIdSet){
        
        List<Case> newCaseList = new List<Case>();
        
        List<Case> listCase = [SELECT id,Equipment__c,Vehicle__c,Equipment__r.Maintenance_Cycle__c,
                               (SELECT Equipment__r.Maintenance_Cycle__c FROM Work_Parts__r) 
                               FROM Case WHERE Id In: caseIdSet];
        
        for(Case cse: listCase){
            Case newCase = new Case();
            if(cse.Equipment__c != NULL )
                newCase.Equipment__c = cse.Equipment__c;
            if(cse.Vehicle__c != NULL )
                newCase.Vehicle__c = cse.Vehicle__c;
            newCase.Type = 'Routine Maintenance';
            newCase.Subject = 'Routine Maintenance Auto-generated';
            newCase.Date_Reported__c = System.today();
            Integer shortSpan = 0;
            if(cse.Work_Parts__r.size() > 0){
                for(Work_Part__c wp : cse.Work_Parts__r){
                    if(wp.Equipment__r.Maintenance_Cycle__c != NULL && (wp.Equipment__r.Maintenance_Cycle__c < shortSpan || shortSpan == 0 )){
                        shortSpan = Integer.ValueOf(wp.Equipment__r.Maintenance_Cycle__c);
                    }
                }
            }
            else if(cse.Equipment__r.Maintenance_Cycle__c != NULL)
            {
                shortSpan = Integer.ValueOf(cse.Equipment__r.Maintenance_Cycle__c);
            }
            newCase.Date_Due__c = System.today().addDays(shortSpan);
            newCaseList.add(newCase);
        }
        
        if(newCaseList.size() > 0){
            INSERT newCaseList;
        }    
    }           
}