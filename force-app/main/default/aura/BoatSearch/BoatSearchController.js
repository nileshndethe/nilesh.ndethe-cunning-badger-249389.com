({
    onFormSubmit : function(component, event, helper) {		       
        var formData  = event.getParam("formData");              
        var boatSearchResultCmp = component.find("boatSearchRslt");        
        var auraMethodResult = boatSearchResultCmp.search(formData.boatTypeId);
    }
})