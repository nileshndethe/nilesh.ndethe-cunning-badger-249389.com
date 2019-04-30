({
    onInit : function(component,event,helper) {        
        component.find("service").getNewRecord(
            "BoatReview__c",
            null,
            false,
            $A.getCallback(function(){
                var rec = component.get("v.boatReview");
                var error = component.get("v.recordError");
                var boat=component.get("v.boat");
                if (error || (rec===null)){
                    console.log("Error initializing record template: " + error);
                    return;
                }  
                else {
                    rec.Boat__c = component.get("v.boat").Id;
                    component.set("v.boatReview", rec);
                    console.log("Record template initialized: " + rec.sobjectType);                   
                }
            })
        );        
    }
})