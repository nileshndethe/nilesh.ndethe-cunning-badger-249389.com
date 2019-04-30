({
    onBoatSelected : function(component, event) {
        var selectedBoat = event.getParam("boat");
        if(selectedBoat) {
            component.set("v.Id",selectedBoat.Id);
            component.set("v.boat",selectedBoat);   
        }      
        component.find("service").reloadRecord();
    },
    onRecordUpdated : function (component, event, helper){        
        var BRcmp = component.find("BRcmp");
        console.log(BRcmp);
        if(typeof BRcmp != 'undefined'){
            
            var auraMethodResult = BRcmp.refresh();
            console.log("auraMethodResult: " + auraMethodResult);
        }
    },
    onBoatReviewAdded : function(component, event, helper) {                
        component.find("details").set("v.selectedTabId", "boatreviewtab");
        var BoatReviews = component.find("BRcmp");
		BoatReviews.refresh();
    }
})