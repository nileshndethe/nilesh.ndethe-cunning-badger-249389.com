({
    onFullDetails : function(component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        if(!$A.util.isUndefinedOrNull(navEvt)){
            component.set("v.isEventSupported", "true");
            navEvt.setParams({
                "recordId" : component.get("v.boat.Id")
            });
            navEvt.fire();
        }
        else{
            component.set("v.isEventSupported", "false");
        }
    }
})