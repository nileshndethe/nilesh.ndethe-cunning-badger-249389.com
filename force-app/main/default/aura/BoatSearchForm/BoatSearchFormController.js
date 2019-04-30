({
    doInit : function (component, event, helper){                
        var action = component.get("c.getBoatTypes");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state==="SUCCESS"){
                component.set("v.BoatTypes", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);                 
    },
    createRecord : function (component, event, helper) {
        var selectedBoatTyp = component.get("v.selectedBoatType");
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "Boat__c",
            "defaultFieldValues": {
                'BoatType__c': selectedBoatTyp
            }
        });
        if(!$A.util.isEmpty(selectedBoatTyp))
            createRecordEvent.fire();
    },
    onFormSubmit : function (component, event, helper){
        var selectedBoatTyp = component.get("v.selectedBoatType");
        var cmpEvt = component.getEvent("formsubmit");
        cmpEvt.setParams({"formData":
                          {"boatTypeId" : selectedBoatTyp}
                         }).fire();
    },
    validate : function (component,event, helper){
        var selectedBoatType = component.get("v.selectedBoatType");
        if(!$A.util.isUndefinedOrNull(selectedBoatType) && !$A.util.isEmpty(selectedBoatType)){
            component.set("v.newBoatTypeEnable", "true");
        }
        else{
            component.set("v.newBoatTypeEnable", "false");
        }
    }
})