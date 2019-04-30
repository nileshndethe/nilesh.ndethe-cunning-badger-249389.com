({
    doInit : function(component, event, helper) {
        helper.onInit(component, event, helper);
    },
    onSave : function(component, event, helper){        
        var boatReviewService = component.find("service");
        boatReviewService.saveRecord($A.getCallback(function(result){
            console.log(result.state);
            var resultToast = $A.get("e.force:showToast");            
            if (result.state === "SUCCESS") {
                if(resultToast){
                    resultToast.setParams({
                        "title" : "Saved",
                        "message" : "The record was saved."
                    });
                    resultToast.fire();
                } else { 
                    alert("The record was saved.");                                       
                }
                var boatReviewAddedEvt = component.getEvent("BoatReviewAdded");                                           
                boatReviewAddedEvt.fire(); 
            } else if (result.state === "ERROR") {
                if(resultToast){
                    console.log('Error: ' + JSON.stringify(result.error));
                    resultToast.setParams({
                        "title" : "Error",
                        "message" : "The was an error saving the record: " + JSON.stringify(result.error)
                    });
                    resultToast.fire();
                } else { alert("The was an error saving the record: " + JSON.stringify(result.error));}
                
            } else {
                console.log('Unknown problem, state: ' + result.state + ', error: '+ JSON.stringify(result.error));
            }
        }));
        helper.onInit(component, event, helper);        
    },
    onRecordUpdated : function(component, event, helper){
        
    }
})