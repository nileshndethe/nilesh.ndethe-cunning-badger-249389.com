public with sharing class WarehouseCalloutService {
    
    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
    // complete this method to make the callout (using @future) to the
    // REST endpoint and update equipment on hand.
    @future(callout=true)
    public static void runWarehouseEquipmentSync(){
        Http htp = new Http();
        HttpRequest htpRequest = new HttpRequest();
        htpRequest.setEndpoint(WAREHOUSE_URL);
        htpRequest.setMethod('GET');
        
        HttpResponse htpResponse = htp.send(htpRequest);
        System.debug('htpResponse >> '+ htpResponse.getBody());
        // On successful request, parse the JSON response.
        if(htpResponse.getStatusCode() == 200){
            List<Object> equipments = (List<Object>) JSON.deserializeUntyped(htpResponse.getBody());
            List<Product2> products = new List<Product2>();
            for(Object o :  equipments){
                Map<String, Object> mapProduct = (Map<String, Object>)o;
                Product2 product = new Product2();
                product.Name = (String)mapProduct.get('name');
                product.Cost__c = (Integer)mapProduct.get('cost');
                product.Current_Inventory__c = (Integer)mapProduct.get('quantity');
                product.Maintenance_Cycle__c = (Integer)mapProduct.get('maintenanceperiod');
                product.Replacement_Part__c = (Boolean)mapProduct.get('replacement');
                product.Lifespan_Months__c = (Integer)mapProduct.get('lifespan');
                product.Warehouse_SKU__c = (String)mapProduct.get('sku');
                product.ProductCode = (String)mapProduct.get('_id');
                products.add(product);
            }
            if(products.size() > 0){
                System.debug(products);
                UPSERT products;
            }
        }
    }
}