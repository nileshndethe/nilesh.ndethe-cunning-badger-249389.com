@IsTest
public class TestDataFactoryUtil {
    public static List<Case> createMaintenanceRequestData(string maintRequestType, integer numsRec, boolean IsWrkPartAvailable) {
        
        List<Case> mtnRequests = new List<Case>();
        
        if (numsRec >0 && maintRequestType.length()>0 ){
            //create Veichle
            Vehicle__c v = new Vehicle__c(Name='TestVehicle 01', VIN_Number__c='aqwepnvaore2424');
            insert v;
            
            //create Equipments: two with different maintenance cycles
            List<Product2> prods = new List<Product2>();
            prods.add(new Product2(Name='TestProduct 01', Warehouse_SKU__c='199911', Lifespan_Months__c=12, Maintenance_Cycle__c=60, Replacement_Part__c=true));
            prods.add(new Product2(Name='TestProduct 02', Warehouse_SKU__c='199922', Lifespan_Months__c=24, Maintenance_Cycle__c=30, Replacement_Part__c=true));
            prods.add(new Product2(Name='TestProduct 03', Warehouse_SKU__c='199923', Lifespan_Months__c=36, Maintenance_Cycle__c=90, Replacement_Part__c=true));
            insert prods; 
            
            //create maintenance requests
            for (integer i = 0; i<numsRec; i++) {
                mtnRequests.add(new Case(Type = maintRequestType, Status='New', Origin='Phone', Vehicle__c=v.id, Equipment__c=prods[2].id, Subject='Test Maintenace Request'));
            }
            insert mtnRequests;
            
            if(!IsWrkPartAvailable){
                //Add two work parts for each maintenance request created
                List<Work_Part__c> wps = new List<Work_Part__c>();
                for (Case c: mtnRequests) {
                    wps.add(new Work_Part__c(Equipment__c=prods[0].id, Maintenance_Request__c=c.id, Quantity__c=1));
                    wps.add(new Work_Part__c(Equipment__c=prods[1].id, Maintenance_Request__c=c.id, Quantity__c=2));
                    wps.add(new Work_Part__c(Equipment__c=prods[2].id, Maintenance_Request__c=c.id, Quantity__c=3));
                }
                insert wps;
            }
        }	
        
        return mtnRequests;
    }
}