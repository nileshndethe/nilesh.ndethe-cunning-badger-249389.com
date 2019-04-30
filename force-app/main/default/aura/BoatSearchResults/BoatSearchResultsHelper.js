({
    onSearch : function(component, event, helper) {    
        var action = component.get("c.getBoats");
        action.setParams({
            "boatTypeId" : component.get("v.boatTypeId")
        });
        action.setCallback(this, function(response){            
            var state = response.getState();
            if(component.isValid() && state==="SUCCESS"){
                component.set("v.boats", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }   
})