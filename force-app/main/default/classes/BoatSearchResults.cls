public with sharing class BoatSearchResults {
    @auraenabled 
    public static List<Boat__c> getBoats(String boatTypeId){        
        //string query = (String.isNotBlank(boatTypeId))?'SELECT Id,Name,Picture__c FROM Boat__c WHERE BoatType__c =  \''+:boatTypeId+')' : 'SELECT Id,Name,Picture__c FROM Boat__c';        
        return (String.isNotBlank(boatTypeId))?[SELECT Id,Name,Picture__c FROM Boat__c WHERE BoatType__c =:boatTypeId] : [SELECT Id,Name,Picture__c FROM Boat__c];            
    }
}