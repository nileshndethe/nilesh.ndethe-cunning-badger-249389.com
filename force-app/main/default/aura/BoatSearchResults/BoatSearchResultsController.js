({
    doSearch : function(component, event,helper) {       
        var params = event.getParam("arguments");   
        if(params){            
            component.set("v.boatTypeId", params.boatTypeId);
            helper.onSearch(component, event,helper);
            return params.boatTypeId;
        }        
    },
    onBoatSelect : function (component, event, helper) {
    	var params = event.getParam("boatId");
    	component.set("v.selectedBoatId",params);
    }
})