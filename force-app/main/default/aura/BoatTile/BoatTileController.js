({
	onBoatClick : function (component, event, helper){		
		var boat = component.get("v.boat");
		var boatSelect = component.getEvent("BoatSelect");
		boatSelect.setParams({
			"boatId" : boat.Id
		});
		boatSelect.fire();
        var btnSelect = component.find("btnTile");
        $A.util.toggleClass(btnSelect,'selected');
        
        var boatSelected = $A.get("e.c:BoatSelected");
        boatSelected.setParams({
            "boat" : boat
        });
        boatSelected.fire();
        
        var lat = boat.Geolocation__Latitude__s;
        var long = boat.Geolocation__Longitude__s;
        var label = boat.Name;      
        var PlotMapMarker = $A.get("e.c:PlotMapMarker");
        PlotMapMarker.setParams({
            "lat"   : lat,
            "long"  : long,
            "label" : label,
            "SObjectId" : boat.Id        
        });
       	PlotMapMarker.fire();
	}
})